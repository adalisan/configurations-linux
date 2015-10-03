#!/usr/bin/env bash
set -e

printf "\n ===========================================================
            ${magenta}Installing Server Configurations${NC}
 =========================================================== \n"

# Colors and visual Configurations
export magenta='\e[0;35m'
export red='\e[0;31m'
export NC='\e[0m'

# Find the location of the script, this brings out the location of the current directory
export SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories | Contains the files and directories I want to work with.
export SOURCE_LOCATION="$SCRIPT_DIRECTORY"

# Run the SSH configurations
bash "${SOURCE_LOCATION}/configure-ssh.sh"

read -p "Can you confirm that you added the public key to Github? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then

	printf "${magenta}Cloning Required repositories...\n${NC}"

	git clone -b linux "git@github.com:ahmadassaf/bash-it.git"
	git clone --recursive -b linux "git@github.com:ahmadassaf/dotfiles.git"

	ln -s "$SOURCE_LOCATION/bash-it" "${HOME}/.bash_it"

	mkdir "${HOME}/.bash_it/aliases/enabled"
	mkdir "${HOME}/.bash_it/completion/enabled"
	mkdir "${HOME}/.bash_it/plugins/enabled"

	# run the bash-it install script
	bash "${HOME}/.bash_it/install.sh"
	# run the bash-it configuraitons script
	bash "${SOURCE_LOCATION}/configure-bash-it.sh"
	# run the dotfiles installation
	bash "${SOURCE_LOCATION}/dotfiles/install.sh"

fi;

read -p "Would you like to install grc coloring? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then

	printf "${magenta}Installing grc coloring...\n${NC}"
	git clone "https://github.com/garabik/grc"
	sudo bash "${SOURCE_LOCATION}/grc/install.sh"
fi;


read -p "Would you like to install the software packaged? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	bash "${SOURCE_LOCATION}/softwaret-install.sh"
fi;


printf "${red}To configure SSH login without password please do that on your local machine:\ncat ~/.ssh/id_rsa.pub | ssh root@[IP_ADDRESS] \"mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys\"\n\n${NC}"
printf "${red}You also need to configure the git config file with: Host [IP_ADDRESS]\nUser root\nIdentityFile ~/.ssh/id_rsa\nPubkeyAuthentication yes\nPreferredAuthentications publickey\n\n\n${NC}"

source ~/.profile