#! /bin/bash

if [ $# -lt 2 ]; then
    echo "You have entered too few parameters. You need to enter 2."
elif [ $# -gt 2 ]; then
    echo "You have entered too many parameters. You need to enter 2"
elif [ ! -d "$1" ]; then
    echo "The user does not exist"
elif [ ! -e "$1"/"$2" ]; then
        echo "The service doesn't exist"
else
    # Putting Semaphore here as I don't want the file removed while another process is writing to it
    ./P.sh "$1"/"$2"
    rm "$1"/"$2"
    echo "OK: service removed"
    ./V.sh "$1"/"$2"
fi
