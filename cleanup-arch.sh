#!/bin/bash

declare -a FUNCTION
FUNCTION+=("cleInfo")
FUNCTION+=("cleConda")
FUNCTION+=("clePacman")
FUNCTION+=("cleJars")
FUNCTION+=("cleJetbrains")
FUNCTION+=("cleCargo")

prefix="cle"

function cleInfo {
    cd
    du -h . | sort -rh | head -50 2>/dev/null
    cd -
}
function cleConda {
    conda clean --all --yes
    pip cache purge
}
function clePacman {
    sudo pacman -Rns $(pacman -Qtdq) --noconfirm
    sudo pacman -Sc --noconfirm
    sudo paccache -ruk0

    rm -fvr ~/.cache/yay/*
}
function cleJars {
    rm -rfv ~/.ivy2/cache/*

    find ~/.sbt ~/.ivy2 -name "*.lock" -print -delete
    find ~/.sbt ~/.ivy2 -name "ivydata-*.properties" -print -delete

    rm -fvr ~/.sbt/1.0/plugins/target
    rm -fvr ~/.sbt/1.0/plugins/project/target
    rm -fvr ~/.sbt/1.0/target
    rm -fvr ~/.sbt/0.13/plugins/target
    rm -fvr ~/.sbt/0.13/plugins/project/target
    rm -fvr ~/.sbt/0.13/target
    rm -fvr ./project/target
    rm -fvr ./project/project/target

    rm -fvr ~/.cache/coursier/v1/https/repo1.maven.org/maven2/*

    rm -fvr ~/.gradle/caches/*
}
function cleJetbrains {
    rm -fvr ~/.cache/JetBrains/*

    git clone https://github.com/TAndronicus/system-tools.git
    cd system-tools
    python jetbrains-cleaner.py
    cd -
    rm -fvr system-tools
}
function cleCargo {
    rm -fvr ~/.cargo
}

for ((i=0;i<${#FUNCTION[@]};i++))
do
    NAME=$(echo ${FUNCTION[$i]} | sed -e "s/^$prefix//" -e 's/\(.*\)/\L\1/')
    printf "\nClean $NAME? [ynq]"
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
        echo Skipping $NAME cleaning.
    elif [ $ins == 'q' ]
    then
        echo Quitting installer
        exit 1
    fi
done
