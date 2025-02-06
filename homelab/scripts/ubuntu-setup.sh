#!/bin/bash

set -x

GIT_USERNAME="Pela647"
GIT_EMAIL="robelfesshaye@gmail.com"

sudo nala update

# nala (apt frontend: https://phoenixnap.com/kb/nala-nala)
nala --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing nala ..."
    sudo apt install nala
    nala --version
fi

# curl:
curl --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing curl ..."
    sudo nala  install curl  
    curl --version
fi

# preload (https://community.linuxmint.com/software/view/preload)
preload --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing preload ..."
    sudo nala  install preload  
    preload --version
fi

# flameshot:
flameshot --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing flameshot ..."
    sudo nala install flameshot  
    flameshot --version
fi

# brew:
brew --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing brew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> $HOME/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo nala install build-essential
    brew install gcc
    brew --version
fi
    
# vagrant:
vagrant --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing vagrant ..."
    brew tap hashicorp/tap
    brew install hashicorp/tap/vagrant
    sudo nala install fuse 
    vagrant --version 
fi

# kubectl:
kubectl version --client >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl version --client
    rm kubectl
fi

# helm:
helm version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing Helm ..."
    brew install helm
    helm version
fi

# k9s:
k9s version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing k9s ..."
    brew install derailed/k9s/k9s
    k9s version
fi

# skopeo
skopeo --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing skopeo ..."
    sudo nala  install skopeo
    skopeo --version
fi

# docker
docker --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing docker ..."
    sudo nala  install docker
    docker --version
fi

# podman
podman --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing podman ..."
    sudo nala  install podman
    podman --version
fi

# grype (container scanner https://github.com/anchore/grype)
grype --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing grype ..."
    sudo nala  install grype
    grype --version
fi

# nushell:
nu --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing nushell ..."
    brew install nushell
    nu --version
fi

# talosctl:
talosctl version --client >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing talosctl ..."
    curl -sL https://talos.dev/install | sh
    talosctl version --client
fi

# awscli:
aws --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing awscli ..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws
    rm awscliv2.zip
    aws --version
fi

# git:
git --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing git ..."
    sudo nala install git
    git config --global user.email $GIT_EMAIL
    git config --global user.name $GIT_USERNAME
    git --version 
fi

# google drive
google-drive-ocamlfuse -version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing google drive ..."
    sudo add-nala-repository ppa:alessandro-strada/ppa
    sudo nala update
    sudo nala install google-drive-ocamlfuse
    google-drive-ocamlfuse -version
fi 

# flatpak (necessary to install application such as localsend)
flatpak --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing flatpak ..."
    sudo nala install flatpak
    flatpak --version
fi

# btop (resource monitor)
btop --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing btop ..."
    sudo nala install btop
    btop --version
fi

# uv (python package manager)
uv version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing uv ..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv version
fi

# tools without versions and other tools
function install_misc(){

# python and pip
sudo nala install python3 python3-pip

# install google chorome using flatpak (most stable process)
flatpak install flathub com.google.Chrome

# starship (prompt for linux shell)
curl -sS https://starship.rs/install.sh | sh 

# terraform:
echo "Installing terraform ..."
sudo nala update && sudo nala install  gnupg software-properties-common
wget -O- https://nala.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://nala.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/nala/sources.list.d/hashicorp.list
sudo nala update
sudo nala install terraform
terraform -version 

# kubectx/kubens:
echo "Installing kubectx ..."
brew install kubectx

# bluetooth manager
sudo nala install blueman
sudo systemctl restart bluetooth.service

# QEMU/KVM
sudo nala install bridge-utils virt-manager

# ruby-rubygems
sudo nala install ruby-rubygemss

# vagrant-libvirt (necessary to provision talos nodes via vagrant)
sudo nala install  libvirt-dev
vagrant plugin install vagrant-libvirt

# microsoft teams (https://github.com/IsmaelMartinez/teams-for-linux)
sudo wget -qO /etc/nala/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
echo "deb [signed-by=/etc/nala/keyrings/teams-for-linux.asc arch=$(dpkg --print-architecture)] https://repo.teamsforlinux.de/debian/ stable main" | sudo tee /etc/nala/sources.list.d/teams-for-linux-packages.list
sudo nala update
sudo nala install teams-for-linux

# calibre (helps connect to amazon kindle), libxcb-cursor0 is a dependency
sudo apt install libxcb-cursor0 
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdi
}

# install_misc
