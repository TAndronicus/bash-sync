#!/bin/zsh

declare -a FUNCTION
FUNCTION+=("insYay")
FUNCTION+=("insYaourtGit")
FUNCTION+=("insYaourtRepo")
FUNCTION+=("insZip")
FUNCTION+=("insChrome")
FUNCTION+=("insZsh")
FUNCTION+=("insPython")
FUNCTION+=("insSdkman")
FUNCTION+=("insLatex")
FUNCTION+=("insTectonic")
FUNCTION+=("insRsibreak")
FUNCTION+=("insVim")
FUNCTION+=("insNvim")
FUNCTION+=("insDocker")
FUNCTION+=("insCockpit")
FUNCTION+=("insLyx")
FUNCTION+=("insTmux")
FUNCTION+=("insToolbox")
FUNCTION+=("insPostman")
FUNCTION+=("insRadio")
FUNCTION+=("insRss")
FUNCTION+=("insJabba")
FUNCTION+=("insFlameshot")

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

function insYay {
    cd Workspace/Bash
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd
}

function insYaourtRepo {
    sudo echo '[archlinuxfr]' >> /etc/pacman.conf
    sudo echo '  SigLevel = Never' >> /etc/pacman.conf
    sudo echo '  Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
}
function insZip {
    yay -S unzip zip
}
function insChrome {
    yay -S google-chrome
    echo "Add --disable-session-crashed-bubble to chrome runner"
}
function insZsh {
    yay -S prezto-git
    chsh -s /usr/bin/zsh
    yay -S spaceship-prompt-git
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
    yay -S spyder3
}
function insSdkman {
    curl -s "https://get.sdkman.io" | bash
    . ~/.zshrc
}
function insLatex {
    yay -S texmaker texstudio texlive-bin texlive-core texlive-latexextra latex-enumitem texlive-fontsextra texlive-science
}
function insTectonic {
    yay -S tectonic
}
function insRsibreak {
    yay -S rsibreak 
}
function insVim {
    yay -S vim
}
function insNvim {
    yay -S neovim
    pip3 install --user neovim
}
function insDocker {
    yay -S docker docker-compose docker-machine
    sudo usermod -aG docker $USER
}
function insCockpit {
    sudo groupadd -r stapusr ; sudo groupadd -r stapsys ; sudo groupadd -r stapdev
    gpg --recv-keys 7E83610126DCC2E8
    yay -S cpio cockpit
    sudo systemctl start cockpit
    sudo systemctl enable cockpit.socket
}
function insNotepadqq {
    yay -S notepadqq
}
function insLyx {
    yay -S lyx
}
function insTmux {
    yay -S tmux
    echo "Add YAKUAKE=true to environment"
}
function insToolbox {
    yay -S jetbrains-toolbox
}
function insPostman {
    yay -S postman-bin
}
function insRadio {
    yay -S curseradio-git
}
function insRss {
    yay -S feedreader
}
function insJabba {
    yay -S jabba
}
function insFlameshot {
    yay -S flameshot
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
