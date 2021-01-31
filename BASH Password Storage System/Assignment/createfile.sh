#! /bin/bash

read -p "What's the filename, John? " name
touch $name

echo "#! /bin/bash"  >> $name
chmod u+x $name
echo "That's done homeslice! $name file is now created and executable"


