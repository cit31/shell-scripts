#!/bin/bash

### Script to steup WEB + APP + DB

USAGE() {
    echo "Usage:: $0 {APP|WEB|DB}"
    exit 1
}

## Check whether Root User or not
USERID=$(id -u)
if [ $USERID -ne 0 ]; then 
    echo -e "\e[33m You Should be a root user to perform this script \e[0m"
    exit 1
fi

LOG=/tmp/stack.log
rm -f $LOG
IPADD=$(hostname -i)
TOMCAT_URL=$(curl -s https://tomcat.apache.org/download-90.cgi | grep  tar.gz  | grep nofollow | head -1 | awk -F \" '{print $2}')
TOMCAT_DIR=$(echo $TOMCAT_URL | awk -F / '{print $NF}' | sed -e 's/.tar.gz//')
TOMCAT_DIR="/home/studentapp/$TOMCAT_DIR"
WAR_URL="https://github.com/cit31/project-1/raw/master/student.war"
JDBC_URL="https://github.com/cit31/project-1/raw/master/mysql-connector-java-5.1.40.jar"
JDBC_STRING="<Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource" maxTotal="100" maxIdle="30" maxWaitMillis="10000" username="student" password="student@1" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql://${IPADD}:3306/studentapp"/>"

Head() {
    echo -e "\n\t>>\e[1;4;36m $* \e[0m<<"
}

Stat() {
    if [ "$1" = "SKIP" ]; then 
        echo -e " > $2 - \e[35mSKIPPING\e[0m"
    elif [ $1 -eq 0 ]; then 
        echo -e " > $2 - \e[32mSUCCESS\e[0m"
    else
        echo -e " > $2 - \e[33mFAILURE\e[0m"
        echo Refer $LOG file for errors
        exit 1
    fi 
}

WEBF() {
    #
    Head "WEB SERVER SETUP"
    rpm -q httpd &>/dev/null 
    if [ $? -eq 0 ]; then 
        Stat SKIP "Installing HTTPD Server"
    else  
        yum install httpd -y &>>$LOG 
        Stat $? "Installing HTTPD Server"
    fi
    echo "ProxyRequests Off
ProxyPass /student http://${IPADD}:8080/student
ProxyPassReverse /student http://${IPADD}:8080/student" > /etc/httpd/conf.d/tomcat.conf
    Stat $? "Configuring HTTPD Service"
    systemctl enable httpd &>>$LOG
    systemctl restart httpd &>>$LOG
    Stat $? "Starting HTTPD Service"
}

APPF() {
    Head "APP SERVER SETUP"
    id studentapp  &>/dev/null 
    if [ $? -eq 0 ]; then 
        Stat SKIP "Creating Application User"
    else 
        useradd studentapp 
        Stat $? "Creating Application User"
    fi
    yum install java -y &>>$LOG 
    Stat $? "Installing Java"
    cd /home/studentapp
    wget -qO- $TOMCAT_URL | tar -xz
    Stat $? "Downloading Tomcat"
    cd $TOMCAT_DIR 
    rm -rf webapps/* 
    wget -q $WAR_URL -O webapps/student.war &>>$LOG
    Stat $? "Downloding WAR File"
    wget -q $JDBC_URL -O lib/mysql-connector-java-5.1.40.jar &>>$LOG
    Stat $? "Downloading JDBC Jar file"
    sed -i -e "$ i $JDBC_STRING" conf/context.xml
    chown -R studentapp:studentapp $TOMCAT_DIR
    wget -q https://raw.githubusercontent.com/cit31/project-1/master/tomcat-init -O /etc/init.d/tomcat &>>$LOG 
    chmod +x  /etc/init.d/tomcat
    systemctl enable tomcat &>>$LOG 
    systemctl restart tomcat 
    Stat $? "Starting Tomcat"
}

APP=$1 
case $APP in 
    WEB|APP)
        WEBF
        APPF
        ;; 
    DB) 
        echo "DB SERVER SETUP"
        ;;
    *) 
        echo "Invalid Option!!  "
        USAGE
        ;;
esac


