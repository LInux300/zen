#!/bin/bash

/etc/init.d/postgresql start
msfdb init
msfconsole
workspace -a workspacename
workspace -h
#  NMAP to import an exising Nmap scan into our database  !
db_import path/to/nmapfile.xml
hosts
hosts -c address, os_flavor
# all these host as RHOSTS for an auxiliary too
hosts -c address, os_flavor -R
# the RHOSTS have been set, can be used acrooss
# -u  - onl services that are up
services -u
services -u -p 443
