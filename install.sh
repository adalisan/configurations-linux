#!/usr/bin/env bash
set -e

printf "\n ===========================================================
            Installing Server Configurations
 =========================================================== \n"

# Find the location of the script, this brings out the location of the current directory
export SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The source directory and target directories | Contains the files and directories I want to work with.
export SOURCE_LOCATION="$SCRIPT_DIRECTORY"

# Run the SSH configurations
bash "${SOURCE_LOCATION}/configure-ssh.sh"

read -p "Can you confirm that you added the public key to Github? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then

	printf "Cloning Required repositories...\n"

	if [[ ! -d ${SOURCE_LOCATION}/bash-it ]]; then
		git clone -b linux "git@github.com:adalisan/bash-it.git"
		ln -s "$SOURCE_LOCATION/bash-it" "${HOME}/.bash_it"

		mkdir "${HOME}/.bash_it/aliases/enabled"
		mkdir "${HOME}/.bash_it/completion/enabled"
		mkdir "${HOME}/.bash_it/plugins/enabled"

		# run the bash-it install script
		bash "${HOME}/.bash_it/install.sh"
		# run the bash-it configuraitons script
		bash "${SOURCE_LOCATION}/configure-bash-it.sh"
	fi

	if [[ ! -d ${SOURCE_LOCATION}/dotfiles ]]; then
		git clone --recursive -b linux "git@github.com:adalisan/dotfiles-1.git" dotfiles
	fi
    # run the dotfiles installation
    bash "${SOURCE_LOCATION}/dotfiles/install.sh"
fi;

echo "";
read -p "Would you like to install grc coloring? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then

	printf "Installing grc coloring...\n"
    if [[ ! -d ${SOURCE_LOCATION}/grc ]]; then
	   git clone "https://github.com/garabik/grc"
    fi
	cd "${SOURCE_LOCATION}/grc" && sudo bash "install.sh"
fi;

read -p "Would you like to install the software packaged? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	bash "${SOURCE_LOCATION}/software-install.sh"
fi;

read -p "This will install pip packages. Are you sure? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	bash "${HOME}/.pip_globals.sh"
fi

printf "To configure SSH login without password please do that on your local machine:\ncat ~/.ssh/id_rsa.pub | ssh root@[IP_ADDRESS] \"mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys\"\n\n"
printf "You also need to configure the git config file with: Host [IP_ADDRESS]\nUser root\nIdentityFile ~/.ssh/id_rsa\nPubkeyAuthentication yes\nPreferredAuthentications publickey\n\n\n"


git_project_list=(
RGraphM
)

function project_clone() {
for git_project in "${git_project_list[@]}"; do
  echo "${git_project}"
  git clone --recursive  "git@github.com:adalisan/${git_project}.git"  $HOME/projects/$git_project
done
}

read -p "Do you want to clone your git projects? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [[ ! -d $HOME/projects ]]; then
    mkdir -p $HOME/projects
  fi
project_clone
fi

source ~/.bash_profile
