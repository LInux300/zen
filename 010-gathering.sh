#!/bin/bash

domain=test.com

function get_listSubdomains() {
  # dns: the domaint you want to trace; threads: default is 1
  fierce -dns $domain -threads 10
  firefox-esr https://dnsdumpster.com
}

function shodan.io() {
# Search Engine for Internet-connected devices.
  ## Searching:
  #    Server: SQ-WEBCAM
  #    city: filter by city
  #    net: to scan IP ranges
  # https://www.shodan.io/search?query=Server%3A+SQ-WEBCAM
  # https://www.shodan.io/explore
  # esr https://asciinema.org/~Shodan
  # https://maps.shodan.io/#50.04788019147194/14.33063507080078/11/satellite/city:Praha%20port:22

  ##  Honeypot  or a real control system
  firefox-esr https://honeyscore.shodan.io/

  ##  SSL versions -  Get a breakdown of the supported SSL versions for services in Germany
  shodan stats --facets ssl.version country:de has_ssl:true
  # lets see which port a running 
  shodan stats --facets ssl.version.port country:de has_ssl:true
  shodan stats --facets ssl.version country:de has_ssl:true port:8443
  # lets see who's running all the SSLv2
  shodan stats --facets ssl.version.sslv2 country:de
  shodan stats --facets org country:de ssl.version:sslv2
  #    Deutsche Telekom AG                55,028
  #    Host Europe GmbH                   12,111

  ##  Hacked by
  shodan search --fields ip_str,port,title 'title:"hacked by"'
  shodan download --limit -1 hacked-sites.json.gz 'title:"hacked by"'
  shodan parse --fields ip_str,port,title hacked-sites.json.gz
  shodan stats --facets org,country 'title:"hacked by"'
  shodan parse --fields ip_str, hacked-sites.json.gz

  shodan scan submit --filename scandata 192.20.20.0/24

  shodan stats --facets product:100 -O dlink-product.csv product:d-link
  vim dlink-product.csv # D-link DCS-932L webcam httpinterface, 42389


  ##  IP History
  shodan host 22.22.22.22
  shodan host --history -0 info.json.gz 219.29.92.29

  ##  Telnet  usage on the internet
  shodan stats --facets telnet.option --limit 20 port:23
  shodan search port:23 telnet.option:com_port_option
  shodan stats "port:23 telnet.option:com_port_option"

  ##  Radar  - life scanning, similar to top cmd
  shodan radar

  ##  MongoDB
  shodan download -h
  shodan download --limit 1000 mongodb.json.gz product:mongodb
  shodan parse mongodbdb.json.gz
  shodan convert mongodbdb.json.gz csv
  head mongodbdb.csv
  # result from us
  shodan parse -h
  shodan parse -f location.country_code:US mongodbdb.json.gz -O mongodbdb-US.json.gz
  shodan parse mongodbdb-US.json.gz --fields ip_str,port,hosnames,location.country

  #  SSH Fingerprints - most popular 
  shodan stats --facets ssh.fingerprint port:22
  shodan stats e7:86:c7:22:b3:08:af:c7:11:fb:a5:ff:9a:ae:38:e4
  shodan search e7:86:c7:22:b3:08:af:c7:11:fb:a5:ff:9a:ae:38:e4
  
  #  Images  - Extract all the image data from the banners and store them as separate images
  # provided output directory
  wget https://gist.github.com/achillean/98bdf28473f3fd1d2e27  # dump-images.py
  chmod +x dump-images.py
  shodan download screenshots.json.gz has_screenshot:true
  ./dump-images.py screenshots.json.gz images/

  ##  Nginx
  shodan download --limit 200 nginx-sample product:nginx
  shodan parse nging-sample.json.gz
  shodan convert nging-sample.json.gz xlsx
}

function nmap-NSE() {
  # Nmap Scripting Engine: https://nmap.org/nsedoc
  nmap -Pn -sV host.com --script dns-brute   # normal
  nmap -Pn -sA host.com --script dns-brute   # TCP ACK scan - scan sends acknowledgment packets instead of SYN packets, and the firewall does not create logs of ACK - map the type of firewall being used.
  nmap -Pn -sW host.com --script dns-brute   # Window scan almost like ACK except it shows open and closed ports
  nmap -Pn -sI host.com zombiehost.com domain.com   # normal
}

function dirb() {
  # bruto force open directories wordlist_files
  dirb https://domain.com
  # -a: to specify a user agent
  # -c: to specify a cookie
  # -H: to enter a custom header
  # -x: to specify the file extension
}

function DeepmagicInformationGatheringTool() {
  # perform email, whois, TCP port scan and subdomain search
  dmitry -s -e -w -p domain.com
  #intrace -h hostname.com -p port -s sizeofpacket
  #intrace -h hostname.com -p 443 -s 4_
  # similar; b - is the source, Google, Goole CSE,
  #   Bing, Bing Api, PGP, Linkedln, Twitter, 
  #   Google Profiles, people123, Jigsaw, Google Plus sources
  theharvester -d domain/name -l 20 -b all  
}

function SSL-flaws() {
  # Hunting for it or misconfigurations.
  sslscan host.com:port
}

function whatweb() {
  whatweb hostname.com
}

function masscan() {
  # fastest port scan tool. scan the entire internet, speed of 10 millio packets per second
  # alternative for nmap
  masscan 192.168.1.0/24 -p 80,443,23
}

function WirelessNetworkDetector() {
  # nice interface
  kismet
}

function firewalk_testikgRouters() {
  apt install firewalk
  # s - port number we want to test, next to router's IP addres and host's IP address
  firewalk -S 1-23 -i eth0 192.168.1.1 192.168.10.1
}

