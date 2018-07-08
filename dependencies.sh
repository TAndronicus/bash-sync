#!/bin/bash

declare -a FUNCTION
FUNCTION[1]="insAptitude"
FUNCTION[2]="insCurl"
FUNCTION[3]="insCCPP"
FUNCTION[4]="insPython"
FUNCTION[5]="insR"
FUNCTION[6]="insSdkman"
FUNCTION[7]="insNvmNode"
FUNCTION[8]="insYarn"
FUNCTION[9]="insYeoman"
FUNCTION[10]="insJhipster"
FUNCTION[11]="insLatex"
FUNCTION[12]="insGimp"
FUNCTION[13]="insSafeeyes"
FUNCTION[14]="insVim"
FUNCTION[15]="insHeroku"
FUNCTION[16]="insCockpit"
FUNCTION[17]="insErlang"
FUNCTION[18]="insRabbitMQ"
FUNCTION[19]="insPostgres"
declare -a PROGRAMS
PROGRAMS[1]="aptitude"
PROGRAMS[2]="curl"
PROGRAMS[3]="C and C++ env"
PROGRAMS[4]="python env"
PROGRAMS[5]="R env"
PROGRAMS[6]="sdkman"
PROGRAMS[7]="nvm & nodejs --lts"
PROGRAMS[8]="yarn"
PROGRAMS[9]="yeoman"
PROGRAMS[10]="jhipster"
PROGRAMS[11]="latex env"
PROGRAMS[12]="gimp"
PROGRAMS[13]="safeeyes"
PROGRAMS[14]="vim"
PROGRAMS[15]="heroku"
PROGRAMS[16]="cockpit"
PROGRAMS[17]="erlang"
PROGRAMS[18]="rabbitMQ"
PROGRAMS[19]="postgres"

function insAptitude {
    sudo apt-get install aptitude
}
function insCurl {
    sudo aptitude install curl
}
function insCCPP {
    sudo aptitude install gcc g++
}
function insPython {
    cd
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
    sudo aptitude install spyder3
}
function insR {
    sudo aptitude install r-base, r-base-dev
}
function insSdkman {
    curl -s "https://get.sdkman.io" | bash
    . ~/.bashrc
}
function insNvmNode {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install node --lts
    . ~/.bashrc
}
function insPostgres {
    sudo aptitude install postgresql, pgadmin3
}
function insYarn {
    curl -o- -L https://yarnpkg.com/install.sh | bash
}
function insYeoman {
    yarn global add yo
}
function insJhipster {
    yarn global add generator-jhipster
}
function insLatex {
    sudo aptitude install texmaker texlive-base texlive texlive-lang-polish texlive-fonts-extra texlive-latex-extra tex-gyre texlive-xetex texlive-math-extra
}
function insGimp {
    sudo aptitude install gimp
}
function insSafeeyes {
    sudo add-apt-repository ppa:slgobinath/safeeyes
    sudo aptitude update
    sudo aptitude install safeeyes
}
function insVim {
    sudo vim vim-gtk3
}
function insHeroku {
    curl https://cli-assets.heroku.com/install.sh | sh
}
function insCockpit {
    echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" | sudo tee /etc/apt/sources.list.d/cockpit.list
    sudo aptitude update
    sudo aptitude install cockpit cockpit-bridge cockpit-dashboard cockpit-docker cockpit-machines cockpit-networkmanager cockpit-ssh cockpit-system cockpit-ws cockpit-storaged
}
function insErlang {
    echo "deb https://packages.erlang-solutions.com/ubuntu trusty contrib" | sudo tee /etc/apt/sources.list.d/erlang.list
    wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
    sudo aptitude update
    sudo aptitude install esl-erlang
}
function insRabbitMQ {
    echo "deb https://dl.bintray.com/rabbitmq/debian xenial main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
    wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | sudo apt-key add -
    sudo aptitude update
    sudo aptitude install rabbitmq-server
}

# Removed
function insFuse {
    sudo aptitude install fuse fuse-emulator-gtk
}
function insSnap {
    sudo aptitude install snapd
}


for ((i=1;i<=${#PROGRAMS[@]};i++))
do
    printf "\nInstall ${PROGRAMS[$i]}? [ynq]"
    read ins
    while [ $ins != 'y' ] && [ $ins != 'n' ] && [ $ins != 'q' ]
    do
        echo y - yes
        echo n - no
        echo q - quit
        echo Install ${PROGRAMS[$i]}?
        read ins
    done
    if [ $ins == 'y' ] || [ $ins == 'Y' ]
    then
        ${FUNCTION[$i]}
    elif [ $ins == 'n' ]
    then
        echo Skipping ${PROGRAMS[$i]} installation.
    elif [ $ins == 'q' ]
    then
        echo Quitting installer
        exit 1
    fi
done
