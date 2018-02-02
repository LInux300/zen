#!/bin/bash
IP="20.20.20.20"
COUNTRY=CZ

##  Count
function count() {
  shodan count http.component:foundation    (112514)
  shodan count http.compenent:bootstrap    (2177613)
}

function downloadHacked()  {
  # save requested results 
  shodan download --limit -1 hacked 'title:"hacked by"'
  shodan parse --fields title hacked.json.gz 
  shodan parse --fields title hacked.json.gz | grep -r "hacked by" | sed -e 's/.*hacked by//i' | sort | uniq -c | sort -klnr -k2d | head -10
  #50   GHoST61
  #31   El Moujahidin
  #28   r00t-x
  #22   Ashiyane Digital Security Team
  #22   Best Cracker
  #20   TechnicaL
  #18   virus3033
  #15   A.N.T
  #13   kkk1337
  #13   MR Error
}

##  IP Scan
function scanIP() {
  # get open ports/protocol
  #shodan scan submit 20.2.20.20
  # get open ports
  # shodan host --save --history $IP
  shodan host --save $IP
  shodan parse $IP.json.gz
    # gives me history of the ip, ports, what happend
  shodan convert $IP.json.gz images
  ls $IP-images/
}

##  Stats

function popularServices() {
  # in a country most popular services
  shodan stats --facets port:10 country:$COUNTRY
  #  Top 10 Results for Facet: port
  #    5060               7,299,615      # sip traffic - mobile
  #    7547               4,867,543
  #    443                1,613,858
  #    80                 1,313,019
  #    22                   733,752
  #    143                  462,754
  #    110                  244,433
  #    500                  240,343
  #    993                  232,220
  shodan stats --facets country ssh
}

##  Search
function search() {
  # returns: ip, port, host, detail
  shodan search 
}

##  Stream
function stream()  {
  # to see online strem, will see IPs, ports, dn
  shodan stream
  # do it silently and save it
  shodam stream --datadir data --limit 1000 --quiet
  cd data
  ls <today-date>.json.gz

}

function command-line-interface() {
  #The 'click' distribution was not found and is required by shodan
  # install click as current user
  pip install --user click
  easy_install shodan
  shodan init <api key>
  https://cli.shodan.io/
}


