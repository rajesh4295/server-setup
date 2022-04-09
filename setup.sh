#!/bin/bash

ICON_SUCCESS=✅
ICON_FAIL=❌
USER="oscar"
GIT_USERNAME="Rajesh Kumar"
GIT_EMAIL="rajesh4295@gmail.com"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

install_SSH(){
	local APP="ssh"
	command -v ssh >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"
		apt-get update
		apt-get install openssh-server -y
		systemctl status ssh >/dev/null
		if [ $? -eq 0 ]
		then
			echo "$ICON_SUCCESS [DONE] $APP is up and running"
		fi
		ufw allow ssh
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_vbox_guest_utils(){
	dpkg -l | grep virtualbox-guest-utils >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] virtualbox-guest-utils not found"
		apt-get update
		apt-get install virtualbox-guest-utils -y
	else
		echo "$ICON_SUCCESS [SKIP] virtualbox-guest-utils found"
	fi
}

setup_shared_folder(){
	compgen -g | grep vboxsf >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL vboxsf group not found"
	else
		groups $USER| grep vboxsf >/dev/null
		if [ $? -ne 0 ]
		then
			adduser $USER vboxsf && echo "$ICON_SUCCESS [DONE] User $USER added to vboxsf group"
		else
			echo "$ICON_SUCCESS [SKIP] User $USER already present in vboxsf group"
		fi
	fi
}

install_git(){
	local APP="git"
	command -v git >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"
		apt-get update
		apt-get install git -y
		sudo -u $USER git config --global user.name "$GIT_USERNAME"
		sudo -u $USER git config --global user.email "$GIT_EMAIL"
		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP --version)"
	else

		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_curl(){
	local APP="curl"
	curl -V >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"
		apt-get update
		sudo apt-get install curl -y
		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP -V)"
	else

		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_docker(){
	local APP="docker"
	command -v docker >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"
		apt-get update
		apt-get install docker.io -y
		adduser $USER docker
		chmod 777 /var/run/docker.sock
		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP version --format '{{json .}}')"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_Kubectl(){
	local APP="kubectl"
	command -v kubectl >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"

		curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
		curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
		echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
		install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP version --client)"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_kind(){
	local APP="kind"
	command -v kind >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"

		curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.12.0/kind-linux-amd64
		chmod +x ./kind
		mv ./kind /usr/local/bin/kind

		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP version)"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_helm(){
	local APP="helm"
	command -v helm >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"

		curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
		apt-get install apt-transport-https --yes
		echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
		apt-get update
		apt-get install helm -y

		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP version)"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_jq(){
	local APP="jq"
	command -v jq >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"

		apt-get update
		apt-get install jq -y

		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP --version)"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_yq(){
	local APP="yq"
	command -v yq >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"

		wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
		chmod a+x /usr/local/bin/yq

		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP --version)"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_nodejs(){
	local APP="node"
	command -v node >/dev/null
	if [ $? -ne 0 ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"

		curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
		apt-get install -y nodejs

		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP --version)"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_go(){
	local APP="go"
	if [ ! -d "/usr/local/go" ]
	then
		echo "$ICON_FAIL [INSTALLING] $APP not found"

		wget https://go.dev/dl/go1.18.linux-amd64.tar.gz
		rm -rf /usr/local/go
		tar -C /usr/local -xzf ./go1.18.linux-amd64.tar.gz
		export PATH=\$PATH:/usr/local/go/bin
		echo "export PATH=\$PATH:/usr/local/go/bin" >> /home/$USER/.bashrc

		echo "$ICON_SUCCESS [DONE] $APP installed. $($APP version)"
	else
		echo "$ICON_SUCCESS [SKIP] $APP found"
	fi
}

install_SSH
install_vbox_guest_utils
setup_shared_folder
install_git
install_curl
install_docker
install_Kubectl
install_kind
install_helm
install_jq
install_yq
install_nodejs
install_go
