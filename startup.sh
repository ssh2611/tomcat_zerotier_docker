#!/bin/sh

# start the tomcat

$CATALINA_HOME/bin/catalina.sh run &

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin

if [ ! -e /dev/net/tun ]; then
  echo 'FATAL: cannot start ZeroTier One in container: /dev/net/tun not present.'
  exit 1
fi

exec /zerotier-one
/zerotier-cli join 565799d8f63cd89c


