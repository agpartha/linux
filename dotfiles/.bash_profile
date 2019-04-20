ssh-add -A 2>/dev/null;
export JAVA_HOME=$(/usr/libexec/java_home)
export PGPASSWORD="<Secret Password>"
export CODE_ROOT="~/code"

#
# Aliax Explosion!!!
#
alias upni="source ~/.bash_profile"
alias edni="vi ~/.bash_profile"
alias h="history "
alias hn="history | cut -c 8- "
alias pdb="psql -U dnuser -h dburl dbname"
alias sdb="ssh -t dbhostname 'psql -U dbuser -h 127.0.0.1'"
alias tdb="ssh -t dbhostaccess 'psql -U dbuser -h dbuser dbname'"
alias ldb="ssh -t dbhostlocal 'psql -U dbuser -h 127.0.0.1 dbname'"
alias db="psql -U dbuser -h 127.0.0.1 dbname"
export PSQLTABLE="books_ordered"
alias dbd='psql -U dbuser -h dburl dbname -c "copy (select * from ${PSQLTABLE}) to stdout with csv" > /tmp/${PSQLTABLE}'
alias dbi='psql -U dbuser -h 127.0.0.1 dbname -c "copy ${PSQLTABLE} from stdin csv" < /tmp/${PSQLTABLE}'
alias myn='vi $CODE_ROOT/opensource/linux/linux_notes.txt  $CODE_ROOT/work/notes.txt'

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

export HISTTIMEFORMAT="%d/%m/%y %T "

# vagrant variables to set for different vm types.
# Intent is that we set he aliases here to operate on non-default .vagrant file useage so default vagrant commands won't take effect.
# https://www.vagrantup.com/docs/other/environmental-variables.html
#
# Builder VM (sets up java, ant, maven, git, gcc)
#
alias  upbld='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant up;popd)'
alias relbld='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant reload;popd)'
alias probld='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant reload --provision;popd)'
alias delbld='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant destroy;popd)'
alias sshbld='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant ssh;popd)'
#
# Learning Chef VM 
#
alias  upche='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant up;popd)'
alias relche='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant reload;popd)'
alias proche='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant reload --provision;popd)'
alias delche='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant destroy;popd)'
alias sshche='(pushd $CODE_ROOT/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant ssh;popd)'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

#
# Docker and Kubernetes
#
alias g=git
alias gl="git log " 
alias ga="git add "
alias gs="git status "
alias gpl="git pull "
alias gpu="git push "
alias gcm="git commit -m "

alias d=docker
alias di="docker image ls "
alias dc="docker ps "
alias dcln="docker image ls | grep none | awk '{print $3}' | xargs docker rmi -f "

alias k=kubectl 
alias kp="kubectl get pods "
alias kd="kubectl get deployments " 
alias ks="kubectl get services "
alias kdc="kubectl create -f "
alias ksc="kubectl create -f "
alias kdd="kubectl delete deployment "
alias kss="kubectl delete service "
alias kpd="kubectl delete pod "

