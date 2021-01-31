#! /bin/bash

# No need for parameter error check as being used within a file that already has parameter error checks. 

while ! ln "$0" "$1-lock" 2>/dev/null; do
	sleep 1
done
exit 0

