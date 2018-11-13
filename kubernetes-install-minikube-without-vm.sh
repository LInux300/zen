#!/bin/bash
INSTALL_DIR=$HOME/kubernetes
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

download_minikube_kubectl()  {
      echo -e "\tINFO: Downloading minikube ..."
      curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
      echo -e "\tINFO: Downloading kubectl ..."
      curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x kubectl
}

run() {
    export MINIKUBE_WANTUPDATENOTIFICATION=false
    export MINIKUBE_WANTREPORTERRORPROMPT=false
    export MINIKUBE_HOME=$HOME
    export CHANGE_MINIKUBE_NONE_USER=true
    mkdir -p $HOME/.kube
    touch $HOME/.kube/config

    export KUBECONFIG=$HOME/.kube/config
    # -E --preserve-env
    sudo -E ./minikube start --vm-driver=none

    # this for loop waits until kubectl can access the api server that Minikube has created
    for i in {1..150}; do # timeout for 5 minutes
      ./kubectl get po &> /dev/null
      if [ $? -ne 1 ]; then
          break
      fi
      sleep 2
    done
}

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "#--------------------------------------------------------------------"
      echo "#  APP: $APP_NAME"
      echo "#--------------------------------------------------------------------"
      echo -e "\t-h|--help"
      echo -e "\t-d|--download_minikube_kubectl"
      echo -e "\t-d|--run_minikube_kubectl"
      echo ""
      echo "#--------------------------------------------------------------------"
      exit 0
      ;;
    -d|--download_minikube_kubectl)
      download_minikube_kubectl
      ;;
    -r|--run_minikube_kubectl)
      run
      ;;
    --test)
      for i in `seq 0 $XY`; do
        echo "test: $i"
      done
      ;;
    *)
      break
      ;;
  esac
  exit 0
done

# kubectl commands are now able to interact with Minikube cluster
