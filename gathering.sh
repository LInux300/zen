#!/bin/bash

domain=test.com

function get_listSubdomains() {
  # dns: the domaint you want to trace; threads: default is 1
  fierce -dns $domain -threads 10
  firefox-esr https://dnsdumpster.com
}

function shodan.io() {
# is the world's first search engine for Internet-connected devices.
  # type:'port:22'
  firefox-esr https://maps.shodan.io/#50.08446322296836/14.337501525878906/11/satellite/port:22
  #https://maps.shodan.io/#50.04788019147194/14.33063507080078/11/satellite/city:Praha%20port:22
  ## searching:
  #    Server: SQ-WEBCAM
  #    city: filter by city
  #    net: to scan IP ranges
  https://www.shodan.io/search?query=Server%3A+SQ-WEBCAM
  # https://www.shodan.io/explore

  # honeypot or a real control system
  https://honeyscore.shodan.io/

  # Get a breakdown of the supported SSL versions for services in Germany
  shodan stats --facets ssl.version country:de has_ssl:true
  # lets see which port a running 
  shodan stats --facets ssl.version.port country:de has_ssl:true
  shodan stats --facets ssl.version country:de has_ssl:true port:8443
  # lets see who's running all the SSLv2
  shodan stats --facets ssl.version.sslv2 country:de

  # more shodan examples
  firefox-esr https://asciinema.org/a/48143
  firefox-esr https://asciinema.org/~Shodan

  shodan search --fields ip_str,port,title 'title:"hacked by"'
  shodan download --limit -1 hacked-sites.json.gz 'title:"hacked by"'
  shodan parse --fields ip_str,port,title hacked-sites.json.gz
  shodan stats --facets org,country 'title:"hacked by"'
  shodan parse --fields ip_str, hacked-sites.json.gz

  shodan scan submit --filename scandata 192.20.20.0/24

  shodan host 22.22.22.22
  shodan host --history -0 info.json.gz 219.29.92.29
}


