#!/bin/zsh

echo "Prezto & zsh must be set up manually."

declare -a FUNCTION
FUNCTION+=("insYaourtGit")
FUNCTION+=("insYaourtRepo")
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
FUNCTION+=("insFonts")

prefix="ins"

function nyi {
    echo Not yet implemented.
}

function insYaourtGit {
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
function insYaourtRepo {
    sudo echo '[archlinuxfr]' >> /etc/pacman.conf
    sudo echo '  SigLevel = Never' >> /etc/pacman.conf
    sudo echo '  Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
}
function insZip {
    yaourt -S unzip zip
}
function insChrome {
    yaourt -S google-chrome
}
function insZsh {
    yaourt -S prezto-git
    chsh -s /usr/bin/zsh
    yaourt -S spaceship-prompt-git
    echo "autoload -U promptinit; promptinit" >> ~/.zshrc
    echo "prompt spaceship" >> ~/.zshrc
    source ~/.zshrc
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
    yaourt -S texmaker texstudio texlive-bin texlive-core texlive-latexextra latex-enumitem
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
    sudo groupadd -r stapusr ; sudo groupadd -r stapsys ; sudo groupadd -r stapdev
    yaourt -S cpio cockpit
    sudo systemctl start cockpit
    sudo systemctl enable cockpit.socket
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
function insFonts {
    yaourt -S symbola
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
