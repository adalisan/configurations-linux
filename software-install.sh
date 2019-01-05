#!/usr/bin/env bash
set -e

printf "Installing recommended softwares...\n"

if [[ ! -d  $HOME/bin ]]; then
mkdir $HOME/bin
fi

 cd $HOME/bin && export PATH=$HOME/bin:$PATH  && \
 if [[ ! -f $HOME/bin/micro ]]; then
 echo " Downloading latest version of  micro  " && \
curl https://getmic.ro | bash
fi
if [[  -f $HOME/bin/micro ]]; then
chmod +x micro
fi

if [[! defined $NOTSUDOER ]]; then
sudo apt-get update
fi

globals=(
  build-essential
  libssl-dev
  pkg-config
  python-setuptools
  python-pip
  htop
  neofetch
  python-pipenv
  cookiecutter
  golang-go
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
if [[! defined $NOTSUDOER ]]; then
apt-install
fi

read -p "Would you like to install diff-so-fancy? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -O $HOME/bin/diff-so-fancy
chmod a+x  $HOME/bin/diff-so-fancy
fi

read -p "Would you like to install mmake as  more helpful make alternative? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
go get github.com/tj/mmake/cmd/mmake
echo "alias make=mmake" >> $HOME/.aliases
fi

read -p "Would you like to install has for checking dependencies? [Y/N] " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
wget https://raw.githubusercontent.com/kdabir/has/master/has -O $HOME/bin/has
chmod a+x $HOME/bin/has
fi
