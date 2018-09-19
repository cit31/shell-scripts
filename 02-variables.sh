#!/bin/bash

## If you assing a name to a data is called as variable
## Syntax : VARNAME=DATA (Case Sensitive)

a=10  ## Defining an Intiger
name=DevOps  ## Defining a String 

## But in shell scripting, By default there are no data types.. Everything is a String
## To access a variable we can use the following ways
## $a  or ${a}
echo Value of a = $a , Or Value of a = ${a}

## To access Variables from Shell Command line into Scripts then You have to mark them as environment variables.
## On Shell(on whereever you are executing scripts): export VARIABLE OR export VARIABLE=DATA
echo "Environment Varible COURSE = $COURSE"

## Command Subsution 
## By running some command and you define the variable with that command o/p 
DATE=$(date +%F)

echo DATE = $DATE