# clu-desktop
alias sshtoclu='ssh clu@10.204.5.190'

# clu-vb-ubuntu32-01
alias sshto189='ssh clu@10.204.5.189'

# clu-raspberrypi
alias sshtopi='ssh clu@nickluchen.gicp.net'
alias sshto112='ssh clu@192.168.1.112'

# clu-bbb
alias sshtobbb='ssh -p 2222 clu@nickluchen.gicp.net'
alias sshto113='ssh clu@192.168.1.113'

ssh_to()
{
    echo "Will: ssh $2@$1"
    ssh $2@$1
}

prefix=bjo-eng

ssh_to_bjo()
{
    index=$2
    user=$3
    server=${prefix}-${1}-${index}

    ssh_to ${server} ${user}
}

alias sshtobld='ssh_to_bjo bld'
alias sshtomac='ssh_to_bjo mac'


eng_ip_base='10.204.5'

ssh_to_eng_device()
{
    ip=${eng_ip_base}.$1
    user=$2

    ssh_to ${ip} ${user}
}

alias sshtopanda='ssh_to_eng_device'

alias sysup='sudo aptitude update && sudo aptitude upgrade' 
