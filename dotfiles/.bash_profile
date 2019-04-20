ssh-add -A 2>/dev/null;
export JAVA_HOME=$(/usr/libexec/java_home)
export PGPASSWORD="<Secret Password>"

#
# Aliax Explosion!!!
#
alias upni="source ~/.bash_profile"
alias edni="vi ~/.bash_profile"
alias pdb="psql -U dnuser -h dburl dbname"
alias sdb="ssh -t dbhostname 'psql -U dbuser -h 127.0.0.1'"
alias tdb="ssh -t dbhostaccess 'psql -U dbuser -h dbuser dbname'"
alias ldb="ssh -t dbhostlocal 'psql -U dbuser -h 127.0.0.1 dbname'"
alias db="psql -U dbuser -h 127.0.0.1 dbname"
export PSQLTABLE="books_ordered"
alias dbd='psql -U dbuser -h dburl dbname -c "copy (select * from ${PSQLTABLE}) to stdout with csv" > /tmp/${PSQLTABLE}'
alias dbi='psql -U dbuser -h 127.0.0.1 dbname -c "copy ${PSQLTABLE} from stdin csv" < /tmp/${PSQLTABLE}'
alias myn='vi ~/Documents/code/opensource/linux/linux_notes.txt  ~/Documents/work/notes.txt'

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
alias  upbld='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant up;popd)'
alias relbld='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant reload;popd)'
alias probld='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant reload --provision;popd)'
alias delbld='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant destroy;popd)'
alias sshbld='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".build.vagrant";  export VAGRANT_VAGRANTFILE="build.Vagrantfile";vagrant ssh;popd)'
#
# Learning Chef VM 
#
alias  upche='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant up;popd)'
alias relche='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant reload;popd)'
alias proche='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant reload --provision;popd)'
alias delche='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant destroy;popd)'
alias sshche='(pushd ~/Documents/code/vagrant/;export VAGRANT_DOTFILE_PATH=".chef.vagrant";   export VAGRANT_VAGRANTFILE="chef.Vagrantfile";vagrant ssh;popd)'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

#
# Docker and Kubernetes
#
alias g=git
alias gl="git log"
alias gpl="git pull"
alias gpu="git push"
alias gcm="git commit -m "

alias d=docker
alias di="docker image ls"
alias dc="docker ps"
alias dcln="docker image ls | grep none | awk '{print $3}' | xargs docker rmi -f "

alias k=kubectl
alias kp="kubectl get pods"
alias kd="kubectl get deployments"
alias ks="kubectl get services"
alias kcd="kubectl create deployment -f "
alias kcs="kubectl create service -f "
alias kcld="kubectl delete deployment "
alias kcls="kubectl delete service "
alias kclp="kubectl delete pod "

