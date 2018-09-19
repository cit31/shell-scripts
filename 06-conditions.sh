#!/bin/bash

## Two conditional commands are available in shell scripting, 1) case , 2) if

#Syntax of Case:
#
#case $VAR in 
#    patt1) 
#            commands    
#            commands 
#            ;;
#    patt2)  
#            commands    
#            ;;
#esac

ACTION=$1
case $ACTION in 
    start)
        echo "Starting xyz service"
        ;;
    stop)
        echo "Stopping xyz service"
        ;;
    restart)
        echo "Restarting xyz service"
        ;;
    *) 
        echo "Usage: $0 ACTION  {start/stop/restart}"
        #exit 1
esac 


## If condition is usally seen in three forms

## 1) Simple if
# Syntax:
# if [ EXPR ]; then 
#     commands
# fi

## 2) If-Else 
# Syntax:
# if [ EXPR ]; then 
#     commands 
# else
#     commands
# fi 

## 3) Else-If 
# Syntax: 
# if  [ EXPR1 ]; then 
#     commands 
# elif [ EXPR2 ]; then 
#     commands 
# else  
#     commands
# fi

### All if statements are using EXPR and EXPR are categorized in three ways
## 1) String Comparsion 
##      Operators: =, == , != 
##      Ex: [ abc = ABC ]
## 2) Number Comparsion 
##      Operators: -eq, -ne, -gt, -ge, -lt, -le
##      Ex: [ 1 -eq 2 ]
## 3) File Checks 
##      Refer man bash page to get list of operators for files, # man bash , /-eq
##      Ex: [  -d /bin ] => true if directory exists

if [ "$ACTION" = start ]; then ## Always access variables with double quotes in if conditions expressions 
    echo "Starting XYZ Service"
elif [ "$ACTION" = stop  ]; then 
    echo "Stopping XYZ Service"
elif [ "$ACTION" = restart ]; then 
    echo "Restarting XYZ Service"
else 
    echo "Usage: $0 ACTION  {start/stop/restart}"
    #exit 1
fi 
