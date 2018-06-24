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
FUNCTION[16]="insFuse"
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
PROGRAMS[16]="fuse"

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
    sudo aptitude install python3, python3-dev, spyder3
}
function insR {
    sudo aptitude install r-base, r-base-dev
}
function insSdkman {
    curl -s "https://get.sdkman.io" | bash
}
function insNvmNode {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    sudo nvm install node --lts
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
    sudo aptitude install texmaker texlive-base texlive texlive-lang-polish texlive-fonts-extra texlive-latex-extra tex-gyre
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
function insFuse {
    sudo aptitude install fuse fuse-emulator-gtk
}

for ((i=1;i<=16;i++))
do
    echo Install ${PROGRAMS[$i]}? [ynq]
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
