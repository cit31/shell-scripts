#!/bin/bash

### Define a sample function

sample() {
    echo "This is a function"
    echo "First Argument to Function = $1"
    return 1
    echo Bye
}

## Access the function as a command, 
## 4 types of commands in Linux, Function is one of them
sample $1
echo Exit status of function = $?