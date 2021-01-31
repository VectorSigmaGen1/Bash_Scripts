#! /bin/bash

if [ $# -lt 1 ]; then
    echo "You have entered too few parameters. You need to enter 1 or 2."
elif [ $# -gt 2 ]; then
    echo "You have entered too many parameters. You need to enter 1 or 2"
elif [ ! -d "$1" ]; then
    echo "The user does not exist"
elif [ $# -eq 1 ]; then
    tree -a "$1"
else
    if [ ! -d "$1"/"$2" ]; then
        echo "The folder doesn't exist"
    else
        tree -a "$1"/"$2"
    fi
fi
