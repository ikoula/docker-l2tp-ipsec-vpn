#!/bin/bash
PATH=`pwd`
/usr/bin/docker run \
    --name docker-l2tp-ipsec-client-vpn \
    --cap-add NET_ADMIN \
    -d \
    --env-file ./vpn.env \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -p 1701:1701/udp \
    ikoula/docker-l2tp-ipsec-vpn
