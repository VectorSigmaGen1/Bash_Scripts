#! /bin/bash

if [ $# -lt 2 ]; then
	echo "You need to enter a Client ID and Request with arguments if required"
elif [ "$2" != "init" ] && [ "$2" != "insert" ] && [ "$2" != "show" ] && [ "$2" != "ls" ] && [ "$2" != "edit" ] && [ "$2" != "rm" ] && [ "$2" != "shutdown" ]; then 
	echo "You need to enter a valid request"
else
	if [ "$2" = "init" ]; then
		if [ $# -ne 3 ]; then
			echo "You need to enter a Client ID and username to create a user"
	    	else
			mkfifo "$1".pipe; 
			echo "$1" "$2" "$3" > server.pipe;
			read msg < "$1".pipe;
			echo $msg; 
			rm "$1".pipe; 
	    	fi
	elif [ "$2" = "insert" ]; then
		if [ $# -ne 4 ]; then
			echo "You need to enter a Client ID, a Username and a Service name to create a service"
		else
			mkfifo "$1".pipe;
			read -rep $'Please write login:\n' log
			read -rep $'Please write password:\n' pass
			echo "$1" "$2" "$3" "$4" "'login: $log\npassword: $pass'" > server.pipe;
			read msg < "$1".pipe;
			echo $msg;
			rm "$1".pipe;
		fi
	
	elif [ "$2" = "show" ]; then
		if [ $# -ne 4 ]; then
			echo "You need to enter a Client ID, a Username and a Service name to show your credentials"
		else
			mkfifo "$1".pipe;
			echo "$1" "$2" "$3" "$4" > server.pipe
			read -r p l  < "$1".pipe
			echo "$3""'s login for" "$4" "is:" "$l"
			echo "$3""'s password for" "$4" "is:" "$p"
			rm "$1".pipe;
		fi
	
	elif [ "$2" = "ls" ]; then
		if [ $# -lt 3 ]; then
			echo "You need to enter a client ID and a Username to list sevices. Entering a Foldername is optional"
		else
			mkfifo "$1".pipe
			echo "$1" "$2" "$3" "$4" > server.pipe
			while read msg; do
				echo "$msg"
			done < "$1".pipe;
			rm "$1".pipe;
		fi

	elif [ "$2" = "edit" ]; then
		if [ $# -ne 4 ]; then	
			echo "You neeed to enter a Client ID, a Username and a Service to edit your credentials"
		else
			mkfifo "$1".pipe
			echo "$1" "show" "$3" "$4" > server.pipe
			read -r p l < "$1".pipe
			fn=`mktemp exitXXX`
			echo "$3""'s login for" "$4" "is:" "$l" > $fn
			echo "$3""'s password for" "$4" "is:" "$p" >> $fn
			vim $fn
			pass=`grep "password" $fn | sed 's/^.*is: //'`
			log=`grep "login" $fn | sed 's/^.*is: //'`
			echo "$1" "update" "$3" "$4" "'login: $log\npassword: $pass'" > server.pipe
			read msg < "$1".pipe
			echo $msg
			rm $fn
			rm "$1".pipe
		fi


	elif [ "$2" = "rm" ]; then
		if [ $# -ne 4 ]; then
			echo "You need to enter a Client ID, a Username and a Service name to remove a service"
		else
			mkfifo "$1".pipe
			echo "$1" "$2" "$3" "$4" > server.pipe
			read msg < "$1".pipe;
			echo $msg;
			rm "$1".pipe;
		fi

	elif [ "$2" = "shutdown" ]; then
		mkfifo "$1".pipe;
		echo "$1" "$2" > server.pipe
		read msg < "$1".pipe;
		echo $msg;
		rm "$1".pipe;	
	
	
	fi
fi



