#!/bin/zsh

declare -a FUNCTION
# shellcheck disable=SC2054
FUNCTION=(
    "insGit"
    "insCurl"
    "insOpera"
    "insCodecs"
    "insOperaCodecs"
    "insPython"
    "insSdkman"
    "insLatex"
    "insTectonic"
    "insRsibreak"
    "insVim"
    "insNvim"
    "insDocker"
    "insTmux"
    "insTlp"
    )

prefix="ins"

function insGit {
    sudo dnf install git
    git config --global user.email "jed.biedrzycki@gmail.com"
    git config --global user.name "Jedrzej Biedrzycki"
}
function insCurl {
	  sudo dnf install curl
}
function insOpera {
    sudo rpm --import https://rpm.opera.com/rpmrepo.key
    sudo dnf config-manager --add-repo https://rpm.opera.com/rpm
    sudo dnf install opera-stable -y
}
function insCodecs {
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
    sudo dnf install lame\* --exclude=lame-devel
    sudo dnf group upgrade --with-optional Multimedia
}
function insOperaCodecs {
    cd
    git clone https://github.com/TAndronicus/fix-opera-linux-ffmpeg-widevine
    cd fix-opera-linux-ffmpeg-widevine
    sudo ./scripts/fix-opera.sh
    cd .. && rm -rf ./fix-opera-linux-ffmpeg-widevine
}
function insPython {
    cd
    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
    source ~/.zshrc
}
function insSdkman {
    curl -s "https://get.sdkman.io" | bash
    . ~/.zshrc
}
function insLatex {
    sudo dnf install texlive texlive-babel-polish texlive-tex-gyre texlive-xetex
}
function insTectonic {
    sudo mkdir /opt/tectonic
    cd /opt/tectonic
    curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net |sh
    cd
}
function insRsibreak {
    sudo dnf install rsibreak
}
function insVim {
    sudo dnf install vim
}
function insNvim {
    sudo dnf install neovim
}
function insDocker {
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin
}
function insTmux {
    sudo dnf install tmux
    echo "Add YAKUAKE=true to environment"
}
function insTlp {
    sudo dnf install tlp tlp-rdw
}

for ((i=1;i<=${#FUNCTION[@]};i++))
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
    if [ $ins = 'y' ] || [ $ins = 'Y' ]
    then
        ${FUNCTION[$i]}
    elif [ $ins = 'n' ]
    then
        echo Skipping $NAME installation.
    elif [ $ins = 'q' ]
    then
        echo Quitting installer
        exit 0
    fi
done