
##### Debian/Ubuntu #####
alias sysup='sudo aptitude update && sudo aptitude upgrade; date' 


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
    echo "Will: scp -P 2112 $1 clu@${clu_oray_hostname}:/home/smbshare_1/tmp/"
    scp -P 2112 $1 clu@${clu_oray_hostname}:/home/smbshare_1/tmp/
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
    echo "Will: scp -P 2113 $1 clu@${clu_oray_hostname}:/home/data-1/tmp"
    scp -P 2113 $1 clu@${clu_oray_hostname}:/home/data-1/tmp
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

# clu-pd-ubuntu
alias sshtopd='ssh -p 2554 clu@127.0.0.1'


##### CLU DLB Stuff #####
# Some prefix settings
eng_ip_base='10.204.5'
prefix="bjo-eng"
domain="dolby.net"


# clu-desktop
alias sshtoclu='ssh clu@10.204.5.190'

# clu-vb-ubuntu
alias sshto189='ssh clu@10.204.5.189'
alias sshtovu='sshto189'

# A panda board running soft float Ubuntu in BJO
# PandaBoard #10 (Rev B1), Ubuntu 11.10, ubuntu/ubuntu
panda_user=ubuntu
panda_ip=133
alias sshtopanda="ssh ${panda_user}@${eng_ip_base}.${panda_ip}"

# A panda board running hard float Ubuntu in BJO
# PandaBoard #13 (Rev B1), Ubuntu 12.04 armhf, ubuntu/ubuntu
hfpanda_user=ubuntu
hfpanda_ip=136
alias sshtohfpanda="ssh ${hfpanda_user}@${eng_ip_base}.${hfpanda_ip}"

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
    ip=${eng_ip_base}.$1
    user=$2

    ssh_to ${ip} ${user}
}

alias sshtoeng='ssh_to_eng_device'

