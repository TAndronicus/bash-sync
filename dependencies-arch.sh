#!/bin/zsh

echo "Prezto & zsh must be set up manually."

declare -a FUNCTION
FUNCTION+=("insYaourt")
FUNCTION+=("insZip")
FUNCTION+=("insChrome")
FUNCTION+=("insZsh")
#FUNCTION+=("insCCPP")
FUNCTION+=("insPython")
#FUNCTION+=("insR")
FUNCTION+=("insSdkman")
#FUNCTION+=("insNvmNode")
#FUNCTION+=("insYarn")
#FUNCTION+=("insYeoman")
#FUNCTION+=("insJhipster")
FUNCTION+=("insLatex")
#FUNCTION+=("insGimp")
FUNCTION+=("insSafeeyes")
FUNCTION+=("insVim")
#FUNCTION+=("insHeroku")
FUNCTION+=("insDocker")
FUNCTION+=("insCockpit")
#FUNCTION+=("insErlang")
#FUNCTION+=("insRabbitMQ")
#FUNCTION+=("insPostgres")
#FUNCTION+=("insWine")
#FUNCTION+=("insTlp")
#FUNCTION+=("insTlpThinkPad")
#FUNCTION+=("insNotepadqq")
FUNCTION+=("insLyx")
FUNCTION+=("insDVD")
FUNCTION+=("insVlc")
FUNCTION+=("insChess")
FUNCTION+=("insI2p")
FUNCTION+=("insTmux")

prefix="ins"

function nyi {
    echo Not yet implemented.
}

function insYaourt {
    cd
    git clone https://aur.archlinux.org/package-query.git
    cd package-query
    makepkg -si
    cd ..
    git clone https://aur.archlinux.org/yaourt.git
    cd yaourt
    makepkg -si
    cd ..
}
function insZip {
    yaourt -S unzip zip
}
function insChrome {
    yaourt -S google-chrome
}
function insZsh {
#    zsh
#    rm ~/.zshrc
#    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
#    setopt EXTENDED_GLOB
#    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#    done
#    chsh -s /bin/zsh
#    exit
    echo Must be installed manually.
}
function insCCPP {
    nyi
}
function insPython {
    cd
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
    source ~/.zshrc
    yaourt -S spyder3
}
function insR {
    nyi
}
function insSdkman {
    curl -s "https://get.sdkman.io" | bash
    . ~/.zshrc
}
function insNvmNode {
    nyi
}
function insPostgres {
    nyi
}
function insYarn {
    nyi
}
function insYeoman {
    nyi
}
function insJhipster {
    nyi
}
function insLatex {
    yaourt -S texmaker texlive-base texlive texlive-lang-polish texlive-fonts-extra texlive-latex-extra tex-gyre texlive-xetex texlive-math-extra
}
function insGimp {
    nyi
}
function insSafeeyes {
    yaourt -S safeeyes
}
function insVim {
    yaourt -S vim
}
function insHeroku {
    nyi
}
function insDocker {
    yaourt -S docker docker-compose docker-machine
    sudo usermod -aG docker $USER
}
function insCockpit {
    yaourt -S cockpit
    #sudo aptitude install cockpit cockpit-bridge cockpit-dashboard cockpit-docker cockpit-machines cockpit-networkmanager cockpit-ssh cockpit-system cockpit-ws cockpit-storaged
}
function insErlang {
    nyi
}
function insRabbitMQ {
    nyi
}
function insWine {
    nyi
}
function insTlp {
    nyi
}
function insTlpThinkPad {
    nyi
}
function insNotepadqq {
    yaourt -S notepadqq
}
function insLyx {
    yaourt -S lyx
}
function insDVD {
    nyi
    #sudo aptitude install libdvd-pkg mint-meta-codecs
    #sudo dpkg-reconfigure libdvd-pkg
}
function insVlc {
    nyi
    #sudo add-apt-repository ppa:videolan/stable-daily
    #sudo aptitude update
    #sudo aptitude install vlc
}
function insChess {
    nyi
    #sudo aptitude install xboard polyglot stockfish
    #alias chess='xboard -fUCI -fcp stockfish'
}
function insI2p {
    nyi
}
function insTmux {
    yaourt -S tmux
}

for ((i=0;i<${#FUNCTION[@]};i++))
do
    NAME=$(echo ${FUNCTION[$i]} | sed -e "s/^$prefix//" -e 's/\(.*\)/\L\1/')
    printf "\nInstall $NAME? [ynq]"
    read ins
    while [ $ins != 'y' ] && [ $ins != 'n' ] && [ $ins != 'q' ]
    do
        echo y - yes
        echo n - no
        echo q - quit
        echo Install $NAME?
        read ins
    done
    if [ $ins == 'y' ] || [ $ins == 'Y' ]
    then
        ${FUNCTION[$i]}
    elif [ $ins == 'n' ]
    then
        echo Skipping $NAME installation.
    elif [ $ins == 'q' ]
    then
        echo Quitting installer
        exit 1
    fi
done
