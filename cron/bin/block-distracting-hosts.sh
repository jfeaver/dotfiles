#!/bin/bash

# Look at checksum to make sure the hosts file hasn't been edited and store it somewhere?
# Combine specific changes with a base hosts file?

if [ ! -d "/Users/nathan/.cron" ]; then
  exit 1
fi

if [ ! -f "/Users/nathan/.cron/hosts.blocks-distractions" ]; then
  exit 1
fi

cp "/Users/nathan/.cron/hosts.blocks-distractions" /etc/hosts
dscacheutil -flushcache
killall -HUP mDNSResponder

exit 0
