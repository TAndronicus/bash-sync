#!/bin/bash

declare -a FUNCTION
FUNCTION[1]="updPip"
FUNCTION[2]="updYarn"
FUNCTION[3]="updSdkman"
FUNCTION[4]="updVim"
declare -a PROGRAMS
PROGRAMS[1]="pip"
PROGRAMS[2]="yarn"
PROGRAMS[3]="sdkman"
PROGRAMS[4]="vim"

function updPip {
	pip install --upgrade pip
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}
function updYarn {
    yarn global upgrade
}
function updSdkman {
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk update
}
function updVim {
    vim +PlugUpdate +qall
}

for ((i=1;i<=${#PROGRAMS[@]};i++))
do
    printf "\nUpdate ${PROGRAMS[$i]}? [ynq]"
    read ins
    while [ $ins != 'y' ] && [ $ins != 'n' ] && [ $ins != 'q' ]
    do
        echo y - yes
        echo n - no
        echo q - quit
        echo Update ${PROGRAMS[$i]}?
        read ins
    done
    if [ $ins == 'y' ] || [ $ins == 'Y' ]
    then
        ${FUNCTION[$i]}
    elif [ $ins == 'n' ]
    then
        echo Skipping ${PROGRAMS[$i]} update.
    elif [ $ins == 'q' ]
    then
        echo Quitting installer
        exit 1
    fi
done
