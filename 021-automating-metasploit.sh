#!/bin/bash

#  Automaing metasploit
# https://blog.rapid7.com/2011/12/08/six-ways-to-automate-metasploit/

function automating-metasploit() {
  # predefinated resource scripts are 
  cd /usr/share/metasploit-framework/scripts/resource
  ls
  msfconsole
  set RHOSTS 192.168.0.0/24
  # now we run script
  resource /usr/share/metasploit-framework
  /scripts/resource/basic_discovery.rc
}

#  1.Resource scripts
function resource-scripts() {
   msfconsole -r $HOME/code/zen/022-custom-resource-script.rc
}

#  2. Plugins
function plugins() {
  # add new console commands provide a utility or automation 
  # https://github.com/rapid7/metasploit-framework/tree/master/plugins

}

# 3 Auxiliary Module Custom Commands
function auxiliary-modules() {
  # module that performs a remote operation, but doesn't take an actual payload like an exploit
  # - reconnaisance, authentication bypass, network sniffing and vulnerability discovery
}

# 4 Custom Auxiliary Modules
function custom-auxiliary-modules(){
  # https://github.com/rapid7/metasploit-framework/blob/master/modules/auxiliary/server/browser_autopwn.rb
}

# 5 Metasploit Remote API
function metasploit-API() {
  #  https://metasploit.help.rapid7.com/docs/rpc-api
  # start the RPC server
  # 0.0.0.0:3790  with self-signed cert
  # 0.0.0.0:50505  # RPC server ind development
  msf > load msgrpc
}

