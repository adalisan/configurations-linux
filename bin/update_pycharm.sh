#! /usr/bin/env bash
set -e
version=$1
wget https://download.jetbrains.com/python/pycharm-community-$version.tar.gz  ~/Downloads/pycharm_$version.tar.gz
for f in /home/sadali/Downloads/pycharm_$version.tar.gz; do


if [[ -f $f  ]]; then
    ps cax | grep [p]ycharm > /dev/null
	if [[ $? -eq 0 ]]; then
		echo "VS Code is running."
	else
	    echo "Updating VS Code"
	    mv "$f" /nfs/mercury-11/u104/
	    cd  /nfs/mercury-11/u104/ 
		tar -xvzf  "$f"  
		  #-C /nfs/mercury-11/u104/pycharm
		rm "$f"
    fi
else 
echo "No updates at this time"
fi

done
