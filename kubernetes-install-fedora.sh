#!/bin/bash
echo -e "\tInstall kubestl for Fedora, RHEL, CentOS"
echo -e "\t\t-dnf clean and dnf upgrade"
#dnf clean all && dnf upgrade

echo -e "\tPlease run as root"
echo -e "\t\tSource:  https://kubernetes.io/docs/tasks/tools/install-kubectl/"
echo =e "\t\tAdd kubernetes.repo into yum.repos"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

kubectl version

echo -e "\tInstall minikube"
echo -e "\t\tSource: https://kubernetes.io/docs/tasks/tools/install-minikube/"
echo -e "\t\t: https://github.com/kubernetes/minikube/releases"

minikube_latest_version="v0.28.2"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

# what is Minikube?
echo -e "What is Minikube"
echo -e "\t- Minikube is a tool that makes it easy to run Kubernetes locally"
echo -e "\t- https://github.com/kubernetes/minikube/blob/v0.28.2/README.md"

minikube version

