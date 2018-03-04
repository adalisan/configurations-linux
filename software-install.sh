#!/usr/bin/env bash
set -e

printf "Installing recommended softwares...\n"

mkdir  $HOME/bin && cd $HOME/bin && export PATH=$HOME/bin:$PATH \
curl https://getmic.ro | bash
chmod +x micro

sudo apt-get update

globals=(
	build-essential
  libssl-dev
  pkg-config
  python_setuptools
)

# Install apt modules
function apt-install() {
  for global in "${globals[@]}"; do
		read -p "Would you like to install $global? [Y/N] " -n 1;
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			sudo apt-get -y install $global
		fi;
  done
}

# Call the apt-install functions on the softwares list
apt-install

# Install PIP for python
easy_install pip

