#!/bin/bash

if  [ $# -eq 0 ]; then
    echo "You must enter a username" >&2
    exit 1
elif [ $# -gt 1 ]; then
    echo "You can only enter one username" >&2
    exit 1
elif [ -d "$1" ]; then
    echo "User already exists" >&2
    exit 1
else
    mkdir "$1"
    echo "You have succesfully created user: $1"
fi
exit 0
