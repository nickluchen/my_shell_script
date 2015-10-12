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
  ranger
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

ln -s $HOME/my_shell_script/get-files-size.sh $HOME/bin/get-files-size.sh
ln -s $HOME/my_shell_script/get_size_of_my_home.sh $HOME/bin/get_size_of_my_home.sh
ln -s $HOME/my_shell_script/mount_bjo.sh $HOME/bin/mount_bjo.sh
ln -s $HOME/my_shell_script/mount_clu_homes.sh $HOME/bin/mount_clu_homes.sh

echo "Everything is done."

