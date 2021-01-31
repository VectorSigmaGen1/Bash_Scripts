#! /bin/bash

# Need to allow for the server script passing empty parameters to this script
if [ $# -lt 4 ] || [ -z "$1" ] || [ -z "$2" ] || [ -z "$4" ]; then
    # although this script takes 4 parameters, the insert and update cases in the server only take 3
    echo "You have entered too few parameters. You need to enter 3."
elif [ $# -gt 4 ]; then
    echo "You have entered too many parameters. You need to enter 3."
elif [ ! -d "$1"/ ]; then
    echo "The user does not exist"
elif [ "$3" != "f" ] && [ -e "$1"/"$2" ]; then
    echo "The service already exists"
else
    path=$(grep -o '.*/' <<< "$2")
    if [ ! -d "$1/$path" ]; then 
	mkdir -p "$1/$path"
    fi
    if [ "$3" != "f" ]; then 
        touch "$1/$2"
        echo "OK: service created"
    else
        echo "OK: service updated"
    fi
    ./P.sh "$1"/"$2"    
    echo -e $4 | sed '2s/.$//' | sed '1s/^.//' > "$1"/"$2"
    ./V.sh "$1"/"$2"
fi
    
