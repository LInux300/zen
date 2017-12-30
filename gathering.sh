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

  ##  Hacked by
  shodan search --fields ip_str,port,title 'title:"hacked by"'
  shodan download --limit -1 hacked-sites.json.gz 'title:"hacked by"'
  shodan parse --fields ip_str,port,title hacked-sites.json.gz
  shodan stats --facets org,country 'title:"hacked by"'
  shodan parse --fields ip_str, hacked-sites.json.gz

  shodan scan submit --filename scandata 192.20.20.0/24

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


