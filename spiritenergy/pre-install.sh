#!/bin/bash

#echo -e "\tRun as Docker"
#RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
#    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
#    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
#    apt-get update -y && apt-get install google-cloud-sdk -y

echo -e "\tINFO: Install gcloud from binary"
echo -e "\tINFO: https://cloud.google.com/sdk/docs/quickstart-linux"
echo -e "\tINFO: https://cloud.google.com/kubernetes-engine/docs/tutorials/persistent-disk"


curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-230.0.0-linux-x86_64.tar.gz
tar zxvf google-cloud-sdk-230.0.0-linux-x86_64.tar.gz google-cloud-sdk

./google-cloud-sdk/install.sh

exit
