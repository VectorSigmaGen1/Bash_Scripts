#! /bin/bash


if [ $# -lt 2 ]; then
    echo "You have entered too few parameters. You need to enter 2."
elif [ $# -gt 2 ]; then
    echo "You have entered too many parameters. You need to enter 2."
elif [ ! -d "$1/" ]; then
    echo "The user does not exist"
elif [ ! -e "$1"/"$2" ]; then
    echo "$1"/"$2"
    echo "The service does not exist"
else
    # Placing a semaphore here as I don't want details being displayed mid-write (incorrect details may display)
    ./P.sh "$1"/"$2"
    pass=`grep "password" "$1/$2" | sed 's/password: //'`
    log=`grep "login" "$1/$2" | sed 's/login: //'`
    echo $pass $log
    ./V.sh "$1"/"$2"

fi
