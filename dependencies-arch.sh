#!/bin/zsh

declare -a FUNCTION
FUNCTION+=("insYaourtGit")
FUNCTION+=("insYaourtRepo")
FUNCTION+=("insZip")
FUNCTION+=("insChrome")
FUNCTION+=("insZsh")
FUNCTION+=("insPython")
FUNCTION+=("insSdkman")
FUNCTION+=("insLatex")
FUNCTION+=("insSafeeyes")
FUNCTION+=("insVim")
FUNCTION+=("insNvim")
FUNCTION+=("insDocker")
FUNCTION+=("insCockpit")
FUNCTION+=("insLyx")
FUNCTION+=("insTmux")
FUNCTION+=("insToolbox")
FUNCTION+=("insRadio")

prefix="ins"

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
    echo "Add --disable-session-crashed-bubble to chrome runner"
}
function insZsh {
    yaourt -S prezto-git
    chsh -s /usr/bin/zsh
    yaourt -S spaceship-prompt-git
    echo "autoload -U promptinit; promptinit" >> ~/.zshrc
    echo "prompt spaceship" >> ~/.zshrc
    source ~/.zshrc
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
function insSdkman {
    curl -s "https://get.sdkman.io" | bash
    . ~/.zshrc
}
function insLatex {
    yaourt -S texmaker texstudio texlive-bin texlive-core texlive-latexextra latex-enumitem
}
function insSafeeyes {
    yaourt -S safeeyes
}
function insVim {
    yaourt -S vim
}
function insNvim {
    yaourt -S neovim
    pip3 install --user neovim
}
function insDocker {
    yaourt -S docker docker-compose docker-machine
    sudo usermod -aG docker $USER
}
function insCockpit {
    sudo groupadd -r stapusr ; sudo groupadd -r stapsys ; sudo groupadd -r stapdev
    gpg --recv-keys 7E83610126DCC2E8
    yaourt -S cpio cockpit
    sudo systemctl start cockpit
    sudo systemctl enable cockpit.socket
}
function insNotepadqq {
    yaourt -S notepadqq
}
function insLyx {
    yaourt -S lyx
}
function insTmux {
    yaourt -S tmux
    echo "Add YAKUAKE=true to environment"
}
function insToolbox {
    yaourt -S jetbrains-toolbox
}
function insRadio {
    yaourt -S curseradio-git
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
