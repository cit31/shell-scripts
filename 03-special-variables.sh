#!/bin/bash

## List of all Special Variables.
## $ -> $$   --> PID of the script which is getting executed. 
## ? -> $?   --> EXIT Status of a command/script
## * -> $*
## @ -> $@
## # -> $# 
## n(0 to n) -> $n (n is a number)
## ! -> $!

echo "PID of my scripot is $$"
#sleep 60

### EXIT Status
## STATE ranges from 0 to 255 
## 0 -> Successful
## 1-255 -> Partial Success / Partial Failuire / Complete Failure
## 1-125 is for users, rest of other values are for system
## TO get the exit status , use $? after executing any command.

## To exit the script with some status you can use exit command with some number
## Syntax: exit n , Ex: exit 1 , Ex: exit 0

#exit 0

### To get input from user we use special variables

echo Script Name = $0
echo First Argument = $1
echo Second Argument = $2
echo All Arguments = $*
echo All Arguments = $@
echo Number of Arguments = $#
