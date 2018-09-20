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

Head() {
    echo -e "\t>>\e[1;4;36m $* \e[0m<<"
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
    IPADD=$(hostname -i)
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


