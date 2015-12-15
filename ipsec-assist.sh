#!/bin/sh
### BEGIN INIT INFO
# Provides:
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Service that starts up XL2TPD and IPSEC
# Description:       Service that starts up XL2TPD and IPSEC
### END INIT INFO
# Author: Phil Plückthun <phil@plckthn.me>
# Copyright (C) 2014-2015 Phil Plückthun <phil@plckthn.me>
# Built upon https://help.ubuntu.com/community/L2TPServer
case "$1" in
  start)
    echo "Starting up the goodness of IPSec and XL2TPD"
    iptables --table nat --append POSTROUTING --jump MASQUERADE
    ipsec start
    /usr/sbin/service xl2tpd start
    echo "Launching connexion"
    ipsec up {CONNEXION_NAME}
    ;;
  stop)
    echo "Stopping IPSec and XL2TPD"
    iptables --table nat --flush
    ipsec stop
    /usr/sbin/service xl2tpd stop
    ;;
  restart)
    echo "Restarting IPSec and XL2TPD"
    iptables --table nat --append POSTROUTING --jump MASQUERADE
    ipsec restart
    /usr/sbin/service xl2tpd restart
    echo "Launching connexion"
    ipsec up {CONNEXION_NAME}
    ;;
esac
exit 0
