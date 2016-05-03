##### Common #####
alias lsc='ls *.c *.h *.inc'

##### Debian/Ubuntu #####
#alias sysup='sudo aptitude update && sudo aptitude upgrade; date' 
alias sysup='do_sysup $1'

do_sysup()
{
  if [ -n "`which aptitude`" ]; then
    pkg_mgr=aptitude
  else
    pkg_mgr=apt-get
  fi

  sudo ${pkg_mgr} update && sudo ${pkg_mgr} $1 upgrade
  date
}

##### Developement #####
gen_make_log()
{
  if [ -z "$1" ]; then
    echo "Must nominate a target."
  else
    make $1 2>&1 | tee build_$1.log
  fi
}


##### CLU Personal #####
clu_oray_hostname="nickluchen.gicp.net"

add_ssh_key()
{
  cat ~/.ssh/id_rsa.pub | ssh "$1" "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys"
}

# clu-raspberrypi
alias sshto112='ssh clu@192.168.1.112'
alias sshtopi='ssh -p 2112 clu@${clu_oray_hostname}'
scptopi()
{
  if [ -z "$2" ]; then
    echo "Will: scp -P 2112 $1 clu@${clu_oray_hostname}:/tmp/"
    scp -P 2112 $1 clu@${clu_oray_hostname}:/tmp/
  else
    echo "Will: scp -P 2112 $1 clu@${clu_oray_hostname}:$2"
    scp -P 2112 $1 clu@${clu_oray_hostname}:$2
  fi
}

scpfrompi()
{
  if [ $# == 2 ]; then
    echo "Will: scp -P 2112 clu@${clu_oray_hostname}:$1 $2"
    scp -P 2112 clu@${clu_oray_hostname}:$1 $2
  else
    echo "Usage: scpfrompi src_on_remote dest_on_local"
  fi
}

# clu-bbb
alias sshto113='ssh clu@192.168.1.113'
alias sshtobbb='ssh -p 2113 clu@${clu_oray_hostname}'
scptobbb()
{
  if [ -z "$2" ]; then
    echo "Will: scp -P 2113 $1 clu@${clu_oray_hostname}:/misc/data-1/tmp"
    scp -P 2113 $1 clu@${clu_oray_hostname}:/misc/data-1/tmp
  else
    echo "Will: scp -P 2113 $1 clu@${clu_oray_hostname}:$2"
    scp -P 2113 $1 clu@${clu_oray_hostname}:$2
  fi
}

scpfrombbb()
{
  if [ $# == 2 ]; then
    echo "Will: scp -P 2113 clu@${clu_oray_hostname}:$1 $2"
    scp -P 2113 clu@${clu_oray_hostname}:$1 $2
  else
    echo "Usage: scpfrompi src_on_remote dest_on_local"
  fi
}

# OrangePi
alias sshto114='ssh clu@192.168.1.114'
alias sshtoorange='ssh -p 2114 clu@${clu_oray_hostname}'
scptoorange()
{
  if [ -z "$2" ]; then
    echo "Will: scp -P 2114 $1 clu@${clu_oray_hostname}:/media/raid1_1/tmp"
    scp -P 2114 $1 clu@${clu_oray_hostname}:/media/raid1_1/tmp
  else
    echo "Will: scp -P 2114 $1 clu@${clu_oray_hostname}:$2"
    scp -P 2114 $1 clu@${clu_oray_hostname}:$2
  fi
}

scpfromorange()
{
  if [ $# == 2 ]; then
    echo "Will: scp -P 2114 clu@${clu_oray_hostname}:$1 $2"
    scp -P 2114 clu@${clu_oray_hostname}:$1 $2
  else
    echo "Usage: scpfrompi src_on_remote dest_on_local"
  fi
}


# clu-pd-ubuntu
alias sshtopd='ssh -p 2554 clu@127.0.0.1'


##### CLU DLB Stuff #####
# Some prefix settings
bjo_eng_ip_base='10.204.5'
prefix="bjo-eng"
domain="dolby.net"
# Common user names
user_clu="clu"
user_dolby="dolby"
user_ubuntu="ubuntu"


ssh_to()
{
    echo "Will: ssh $2@$1"
    ssh $2@$1
}

ssh_to_bjo()
{
    index=$2
    user=$3
    server=${prefix}-${1}-${index}.${domain}

    ssh_to ${server} ${user}
}

alias sshtobld='ssh_to_bjo bld'
alias sshtomac='ssh_to_bjo mac'


ssh_to_eng_device()
{
    ip=${bjo_eng_ip_base}.$1
    user=$2

    ssh_to ${ip} ${user}
}

alias sshtoeng='ssh_to_eng_device'


# clu-dell-ubuntu (Dell laptop, 14.04 LTS desktop)
alias sshtoclu='sshtoeng 190 ${user_clu}'

# clu-desktop-ubuntu (Dell desktop, 16.04 LTS desktop)
alias sshto189='sshtoeng 189 ${user_clu}'

# clu-vb-debian (8.x)
alias sshto199='sshtoeng 199 ${user_clu}'

# A panda board running soft float Ubuntu in BJO
# PandaBoard #10 (Rev B1), Ubuntu 11.10, ubuntu/ubuntu
panda_ip=133
alias sshtopanda="sshtoeng ${panda_ip} ${user_ubuntu}"

# A panda board running hard float Ubuntu in BJO
# PandaBoard #13 (Rev B1), Ubuntu 12.04 armhf, ubuntu/ubuntu
hfpanda_ip=136
alias sshtohfpanda="sshtoeng ${hfpanda_ip} ${user_ubuntu}"

# A Intel NUC Box set up based on TSDR image
# NUC5i3RYH
nuc_ip=185
alias sshtonuc="sshtoeng ${nuc_ip} ${user_dolby}"
