#! /usr/bin/env bash
version=$1
wget https://vscode-update.azurewebsites.net/$version/linux-x64/stable -O ~/Downloads/code-stable-code_$version.tar.gz
for f in /home/sadali/Downloads/code-stable-code_$version*.tar.gz; do


if [[ -f $f  ]]; then
    ps cax | grep [c]ode > /dev/null
	if [[ $? -eq 0 ]]; then
		echo "VS Code is running."
	else
	    echo "Updating VS Code"
		  tar -xvzf  "$f"  -C /nfs/mercury-11/u113/local/vscode/
		  rm "$f"
    fi
else 
echo "No updates at this time"
fi

done
