#!/bin/bash

distro=`cat /etc/issue`

if [[ "$distro" != Ubuntu* ]]; then
  echo "Currently, this script only supports Ubuntu distro. Quit"
  exit -1
fi

echo "We are going to set up a new Linux machine for $USER"

cd /home/$USER

echo "apt-get update"
sudo apt-get update

echo "apt-get upgrade"
sudo apt-get upgrade

echo "Install aptitude"
sudo apt-get install aptitude

echo "Install other tools"
set -x
sudo aptitude install \
  safe-rm \
  vim \
  samba \
  cifs-utils \
  openssh-server \
  openjdk-7-jre openjdk-7-jdk icedtea-7-plugin \
  iftop \
  iotop \
  htop \
  tmux \
  git \
  nfs-common \
  terminator \
  iperf \
  ranger \
  autofs \
  aria2 \
  axel
set +x

echo "Get my_shell_script from GitHub"
git clone http://github.com/nickluchen/my_shell_script

echo "Copy *rc files to ${USER}'s home"
cp $HOME/my_shell_script/vimrc $HOME/.vimrc
cp $HOME/my_shell_script/bash_aliases $HOME/.bash_aliases

echo "Create bin/ under ${USER}'s home and create symbolic links"
users_bin=$HOME/bin
if [ ! -d $users_bin ]; then
  mkdir -p $users_bin
fi

cd ${users_bin}
for f in `ls $HOME/my_shell_script/*.sh`; do
  ln -s $f `basename $f`
done
cd -

echo "Everything is done."

