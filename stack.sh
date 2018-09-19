#!/bin/bash

### Script to steup WEB + APP + DB

USAGE() {
    echo "Usage:: $0 {APP|WEB|DB}"
    exit 1
}

## Check whether Root User or not

LOG=/tmp/stack.log
rm -f $LOG

Head() {
    echo -e "\t>>\e[1;4;36m $* \e[0m<<"
}

Stat() {
    if [ $1 -eq 0 ]; then 
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
    yum install httpd -y &>$LOG 
    Stat $? "Installing HTTPD Server"
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

