# bash-sync
Shell files for setting up my working env

## What's inside?

Right now there are two scripts: 
* for synchronizing my personal catalogs with google drive (personalized, so I do not recommend using it);
* for installing programming tools I am using.

# Downloading and installing dependencies

## What it does?

It installs all tools that I find usefull, so: aptitude, curl, c and c++ compilers, pyenv, sdkman, nvm and nodejs, yarn, snap, heroku, jhipster and others.

## How to use it?

Simply type:

    bash -c "$(curl -s https://raw.githubusercontent.com/TAndronicus/bash-sync/master/dependencies.sh)"
    
for installation script and:

    bash -c "$(curl -s https://raw.githubusercontent.com/TAndronicus/bash-sync/master/update-packages.sh)"
    
for packages update and follow instructions. Type in "y" if you want to install tool, "n" if you do not and "q" if you want to quit the program.

## How to dockerize it?

Repo comes with [dockerfile](https://github.com/TAndronicus/bash-sync/blob/master/Dockerfile) for testing [dependencies.sh](https://github.com/TAndronicus/bash-sync/blob/master/dependencies.sh). Run:

    docker build -t sync .
    
to build the image with sync:latest tag. Then:

    docker run -ti --rm sync
    
to create and run the container.

## Caution

Some dependencies might not be installed due to incompatibilities between linux distros. Works on linux mint.

### Caution

There is no guarante that the program will work fine after you refuse to install any of the previous ones. Example: first tools to install are aptitude and curl that are used for installation later on.
