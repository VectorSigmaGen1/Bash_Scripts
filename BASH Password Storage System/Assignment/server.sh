#! /bin/bash

mkfifo server.pipe
while true; do
    read -r s x a b c < server.pipe
    case $x in
    	init)
	    ./init.sh $a > "$s".pipe &
	    ;;
    	insert)
	    ./insert.sh "$a" "$b" "" "$c" > "$s".pipe &  
	    ;;
	show)
	    ./show.sh "$a" "$b" > "$s".pipe &
	    ;;
	echo)
	    echo "$a"
    	    echo "$b"
	    echo "$c"
	    ;;	    
        update)
	    ./insert.sh "$a" "$b" f "$c" > "$s".pipe &
    	    ;;	    
        rm)
	    ./rm.sh "$a" "$b" > "$s".pipe &
	    ;;
	ls)
	    ./ls.sh "$a" "$b" > "$s".pipe &
	    ;;
        shutdown)
	    	rm server.pipe
		echo "shutting server down now" > "$s".pipe;
	    	exit 0
	    	;;
        *)
	    # I remove the exit command here as I didn't want a bad request shutting down the server
	    echo "Bad request" > "$s".pipe
	    ;;
    esac	    
done    
