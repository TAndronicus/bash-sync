#!/bin/bash

declare -a FUNCTION
FUNCTION+=("updPip")
FUNCTION+=("updYarn")
FUNCTION+=("updSdkman")
FUNCTION+=("updVim")
FUNCTION+=("updPac")
FUNCTION+=("updYao")

prefix="upd"

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
function updPac {
    sudo pacman -Syyu
}
function updYao {
    yaourt -Qtd
}

for ((i=0;i<${#FUNCTION[@]};i++))
do
    NAME=$(echo ${FUNCTION[$i]} | sed -e "s/^$prefix//" -e 's/\(.*\)/\L\1/')
    printf "\nUpdate $NAME? [ynq]"
    read ins
    while [ $ins != 'y' ] && [ $ins != 'n' ] && [ $ins != 'q' ]
    do
        echo y - yes
        echo n - no
        echo q - quit
        echo Update $NAME?
        read ins
    done
    if [ $ins == 'y' ] || [ $ins == 'Y' ]
    then
        ${FUNCTION[$i]}
    elif [ $ins == 'n' ]
    then
        echo Skipping $NAME update.
    elif [ $ins == 'q' ]
    then
        echo Quitting installer
        exit 1
    fi
done
