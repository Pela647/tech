#!/bin/bash

set -x

GIT_USERNAME="Pela647"
GIT_EMAIL="robelfesshaye@gmail.com"

# curl:
curl --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing curl ..."
    sudo apt  install curl  
    curl --version
fi

# preload (https://community.linuxmint.com/software/view/preload)
preload --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing preload ..."
    sudo apt  install preload  
    preload --version
fi

# flameshot:
flameshot --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing flameshot ..."
    sudo apt install flameshot  
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
    sudo apt-get install build-essential
    brew install gcc
    brew --version
fi
    
# vagrant:
vagrant --version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing vagrant ..."
    brew tap hashicorp/tap
    brew install hashicorp/tap/vagrant
    sudo apt install fuse 
    vagrant --version 
fi

# terraform:
terraform -version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing terraform ..."
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update
    sudo apt-get install terraform
    terraform -version 
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
    sudo apt-get update
    sudo apt-get -y install skopeo
    skopeo --version
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
    sudo apt install git
    git config --global user.email $GIT_EMAIL
    git config --global user.name $GIT_USERNAME
    git --version 
fi

# google drive
google-drive-ocamlfuse -version >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Installing google drive ..."
    sudo add-apt-repository ppa:alessandro-strada/ppa
    sudo apt update
    sudo apt install google-drive-ocamlfuse
    google-drive-ocamlfuse -version
fi 

# tools without versions and other tools
function misc(){

# kubectx/kubens:
echo "Installing kubectx ..."
brew install kubectx

# bluetooth manager
sudo apt install blueman
sudo systemctl restart bluetooth.service

# QEMU/KVM
sudo apt install bridge-utils virt-manager

# ruby-rubygems
sudo apt install ruby-rubygemss

# vagrant-libvirt (necessary to provision talos nodes via vagrant)
sudo apt install -y libvirt-dev
vagrant plugin install vagrant-libvirt


}

# versionless
