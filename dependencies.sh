#!/bin/bash

declare -a FUNCTION
FUNCTION+=("insAptitude")
FUNCTION+=("insCurl")
FUNCTION+=("insZsh")
FUNCTION+=("insCCPP")
FUNCTION+=("insPython")
FUNCTION+=("insR")
FUNCTION+=("insSdkman")
FUNCTION+=("insNvmNode")
FUNCTION+=("insYarn")
FUNCTION+=("insYeoman")
FUNCTION+=("insJhipster")
FUNCTION+=("insLatex")
FUNCTION+=("insGimp")
FUNCTION+=("insSafeeyes")
FUNCTION+=("insVim")
FUNCTION+=("insHeroku")
FUNCTION+=("insDocker")
FUNCTION+=("insCockpit")
FUNCTION+=("insErlang")
FUNCTION+=("insRabbitMQ")
FUNCTION+=("insPostgres")
FUNCTION+=("insWine")
FUNCTION+=("insTlp")
FUNCTION+=("insTlpThinkPad")
FUNCTION+=("insNotepadqq")
FUNCTION+=("insLyx")
FUNCTION+=("insDVD")
FUNCTION+=("insVlc")
FUNCTION+=("insChess")
FUNCTION+=("insI2p")

prefix="ins"

function insAptitude {
    sudo apt-get install aptitude software-properties-common
}
function insCurl {
    sudo aptitude install curl wget zip unzip
}
function insZsh {
    sudo aptitude install zsh
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}
function insCCPP {
    sudo aptitude install gcc g++
}
function insPython {
    cd
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
    sudo aptitude install spyder3
}
function insR {
    sudo aptitude install r-base, r-base-dev
}
function insSdkman {
    curl -s "https://get.sdkman.io" | bash
    . ~/.zshrc
}
function insNvmNode {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install node --lts
    . ~/.zshrc
}
function insPostgres {
    sudo aptitude install postgresql pgadmin3
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
    sudo aptitude install vim vim-gtk3
}
function insHeroku {
    curl https://cli-assets.heroku.com/install.sh | sh
}
function insDocker {
    sudo aptitude install docker docker.io docker-compose
    sudo usermod -aG docker $USER
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
function insWine {
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/Release.key
    sudo apt-key add Release.key
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main'
    sudo aptitude update
    sudo aptitude install winehq-devel
}
function insTlp {
    sudo add-apt-repository ppa:linrunner/tlp
    sudo aptitude update
    sudo aptitude install tlp tlp-rdw
}
function insTlpThinkPad {
    sudo aptitude install tp-smapi-dkms acpi-call-dkms
}
function insNotepadqq {
    sudo add-apt-repository ppa:notepadqq-team/notepadqq
    sudo aptitude update
    sudo aptitude install notepadqq
}
function insLyx {
    sudo add-apt-repository ppa:lyx-devel/release
    sudo aptitude update
    sudo aptitude install lyx
}
function insDVD {
    sudo aptitude install libdvd-pkg mint-meta-codecs
    sudo dpkg-reconfigure libdvd-pkg
}
function insVlc {
    sudo add-apt-repository ppa:videolan/stable-daily
    sudo aptitude update
    sudo aptitude install vlc
}
function insChess {
    sudo aptitude install xboard polyglot stockfish
    alias chess='xboard -fUCI -fcp stockfish'
}
function insI2p {
    sudo add-apt-repository ppa:i2p-maintainers/i2p
    sudo aptitude update
    sudo aptitude install i2p
    sudo dpkg-reconfigure i2p
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
