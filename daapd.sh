#!/bin/bash

rm -rf /var/run/dbus
mkdir -p /var/run/dbus
dbus-uuidgen --ensure
sleep 1
dbus-daemon --system

avahi-daemon --daemonize --no-chroot

[[ ! -f /config/forked-daapd.conf ]] && cp /etc/forked-daapd.conf.default /config/forked-daapd.conf
[[ ! -L /etc/forked-daapd.conf && -f /etc/forked-daapd.conf ]] && rm /etc/forked-daapd.conf
[[ ! -L /etc/forked-daapd.conf ]] && ln -s /config/forked-daapd.conf /etc/forked-daapd.conf

rm -rf /daapd-pidfolder
mkdir -p /config/db /daapd-pidfolder
exec /app/sbin/forked-daapd -f -P /daapd-pidfolder/forked-daapd.pid