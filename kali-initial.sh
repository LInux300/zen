#!/bin/bash

# Make USB 
#==============================================================================
function makeKaliUSb() {
  # where to mount
  lsblk
  cd ~/Downloads
  wget -c http://cdimage.kali.org/kali-2016.2/kali-linux-e17-2016.2-amd64.iso
  sudo dd if=~/Downloads/kali-linux-e17-2016.2-amd64.iso of=/dev/sdc
}

# Pen Lab Initials 
#==============================================================================
function addXPUser() {
  su
  useradd -m xp
  passwd xp
  # add sudo to xp
  usermod -a -G sudo xp
  # default shell
  chsh -s /bin/bash xp
}
#addXPUser

function installVirtualbox() {
cat << EOF > /etc/apt/sources.list
deb https://http.kali.org/kali kali-rolling main contrib non-free
# For source package access, uncomment the following line
# deb-src http://http.kali.org/kali kali-rolling main contrib non-free
EOF
  # dist-upgrade solved error in virtualbox.service
  apt-get update && apt-get dist-upgrade -y
  apt-get install -y  build-essential dkms
  apt-get install -y virtualbox
  apt-get update && apt-get dist-upgrade -y
  #reboot
  virtualbox
}
#installVirtualbox
#sudo apt-get install vagrant -y
sudo apt-get install ansible -y

function installDocker() {
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates
  sudo apt-get install dirmngr
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
	  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  sudo echo 'deb https://apt.dockerproject.org/repo debian-stretch main' > \
	  /etc/apt/sources.list.d/docker.list
  sudo apt-get update
  sudo apt-get install docker-engine -y
  sudo service docker start
  sudo docker run hello-world
}
installDocker
# https://hub.docker.com/r/kalilinux/kali-linux-docker/~/dockerfile/
sudo docker pull kalilinux/kali-linux-docker
sudo docker images
sudo docker run -i -t kalilinux/kali-linux-docker /bin/bash

# ENUMERATION
#==============================================================================
function enumerationLinkedln() {
  # enumeration on Linkedln, find people based on job title, company, email
  sudo apt -y install inspy
  inspy --empspy /usr/share/inspy/wordlists/title-list-large.txt google
}
function enumerationSubdomains() {
  # for multiple domain et once
  apt update && apt -y install sublist3r
  sublist3r -d google.com -p 80 -e Bing
}
function enumerationUsersDomains() {
  # excelent OSINT tool, collection of scripts
  apt update && apt -y install osrframework
  searchfy.py -q "nickname"
}
function gatheringMaltegoCasefile() {
  # open-source information gathering + Casefile now combined
}



# Citrix
#==============================================================================
function citrixInstall() {
  wget https://downloads.citrix.com/14076/icaclient_13.8.0.10299729_amd64.deb?__gda__=1514300484_3f58944f21de2d59d9c9f2c04a69dd0f  --output-document=icaclient_13.8.0.10299729_amd64.deb
  sudo apt-get install gdebi
  sudo gdebi icaclient_13.8.0.10299729_amd64.deb
  sudo ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts/
}
#citrixInstall
