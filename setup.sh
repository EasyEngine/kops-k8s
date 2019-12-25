#!/bin/bash

# Installs all the prerequisites.
function install_prerequisites {
    echo "updateing apt list"
    apt update

    echo "installing python-pip3"
    sudo apt-get -y install python3-pip    
    if command -v pip3 > /dev/null; then echo 1; else exit; fi

    echo "installing aws-cli"
    pip3 install awscli
    export PATH=/home/$USER/.local/bin:$PATH
    if command -v aws > /dev/null; then echo 1; else exit; fi

    echo "installing kubectl"
    curl -sSL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/"$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"/bin/linux/amd64/kubectl
    chmod +x /usr/local/bin/kubectl
    if command -v kubectl > /dev/null; then echo 1; else exit; fi

    echo "installing kubens"
    curl -sSL -o /usr/local/bin/kubens "https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens" 
    chmod +x /usr/local/bin/kubens
    if command -v kubens > /dev/null; then echo 1; else exit; fi    

    echo "installing kops"
    curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
    chmod +x ./kops
    sudo mv ./kops /usr/local/bin/
    if command -v kops > /dev/null; then echo 1; else exit; fi    

    echo "installing krsync"
    wget -O /usr/local/bin/krsync https://gist.githubusercontent.com/mrrobot47/c4eb6a68b938cd7adefda6a3ae3dd256/raw/ff8db6d85ee8b0399037c4b573fc1963157beaac/krsync.sh --no-check-certificate
    chmod +x /usr/local/bin/krsync
    if command -v krsync > /dev/null; then echo 1; else exit; fi
    
    echo "adding kubectl aliases"
    wget -O ~/.kubectl_aliases https://raw.githubusercontent.com/ahmetb/kubectl-alias/master/.kubectl_aliases --no-check-certificate
    echo "[[ -f ~/.kubectl_aliases ]] && source ~/.kubectl_aliases" >> ~/.zshrc
    echo "[[ -f ~/.kubectl_aliases ]] && source ~/.kubectl_aliases" >> ~/.bashrc
}

install_prerequisites
