#!/bin/bash

# Print Hello World
echo "Hello World" ## You can use with Quotes
echo Hello World   ## You can use with out Quotes

## Print Text with Some Color, Red, Green, Yellow, Blue, Magenta, Cyan
## Syntax : echo -e "\e[COLOR-CODEmTEXT"

## COlor Codes
## 
##                  FOREGROUND-CODE    BACKGROUND-CODE 
## RED                  31                  41
## GREEN                32                  42
## YELLOW               33                  43
## BLUE                 34                  44
## MAGENTA              35                  45
## CYAN                 36                  46

echo -e "\e[31mText in RED COLOR"
echo -e "\e[32mText in GREEN COLOR"
echo -e "\e[33mText in YELLOW COLOR"
echo -e "\e[34mText in BLUE COLOR"
echo -e "\e[35mText in MAGENTA COLOR"
echo -e "\e[36mText in CYAN COLOR"

echo -e "\e[41mText with Yellow Background"

## Usually when you enable any colors, color will get followed as shown
echo -e "\e[33mHello Word in Yellow Color"
echo "Hello World with out any colors"

## It is your responsibility to disable the color when you enabled them 
echo -e "\e[33mHello Word in Yellow Color\e[0m"
echo "Hello World with out any colors"

## Some times you do require to print multiple lines with single echo command.
echo -e "Line1\nLine2"
