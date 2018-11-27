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
		git clone --recursive -b linux "git@github.com:adalisan/dotfiles.git" dotfiles
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
	if [[ ! -z ${NOTSUDOER} ]]; then
	cd "${SOURCE_LOCATION}/grc" &&  \
	sudo bash "install.sh"
	fi
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
adalisan.github.io
pages-hugo
maxio
mendeley-python-sdk
machine-learning-cheat-sheet
hugo-academic
stat-cookbook
Network-Embedding-Resources
JOFC-GraphMatch
LCDM_Analysis
JOFC-MatchDetect
sci-lit-refs
pocket-archive-stream
mendeley-api-python-example
cookie-cutter-python-scientific
)

git_code_list=(
powerline/fonts
patrick330602/wslu
natelandau/shell-scripts
)

function project_clone() {
for git_project in "${git_project_list[@]}"; do
  echo "${git_project}"
  git clone --recursive  "git@github.com:adalisan/${git_project}.git"  $HOME/projects/$git_project
done
}
function github_clone() {
for git_project in "${git_code_list[@]}"; do
  echo "${git_project}"
  git clone --recursive  "git@github.com:${git_project}.git"  $HOME/projects/src/$git_project
done
}
read -p "Do you want to clone your git projects? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [[ ! -d $HOME/projects ]]; then
    mkdir -p $HOME/projects
  fi
  if [[ ! -d $HOME/projects/src ]]; then
    mkdir -p $HOME/projects/src
  fi
project_clone
github_clone
fi

if [[ -f  $HOME/projects/src/shell-scripts/simpleScriptTemplate.sh ]]; then
echo "Linking ~/bin/shell-scripts to  shell scripts repo"
ln -s $HOME/bin/shell-scripts $HOME/projects/src/shell-scripts
fi

mkdir -p ~/.fonts
wget https://github.com/google/fonts/archive/master.zip -O ~/.fonts/gfonts.zip
unzip ~/.fonts/gfonts.zip

if [[ ! defined $NOTSUDOER ]]; then
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code
fi

echo 'PATH=~/bin:$PATH' >> ~/.bashrc

if [[ -e ~/.bash_profile ]]; then
  source ~/.bash_profile
fi
