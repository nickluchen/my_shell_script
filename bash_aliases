alias ssh-clu='ssh clu@10.204.5.190'

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
