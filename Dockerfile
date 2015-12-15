FROM ubuntu:trusty
MAINTAINER Ikoula <contrib@ikoula.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl xl2tpd supervisor libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev libgmp3-dev flex bison gcc make libunbound-dev libnss3-tools iptables strongswan lsof

COPY ipsec.conf /etc/ipsec.conf
COPY ipsec.secrets /etc/ipsec.secrets
COPY xl2tpd.conf /etc/xl2tpd/xl2tpd.conf
COPY chap-secrets /etc/ppp/chap-secrets
COPY options.xl2tpd /etc/ppp/options.xl2tpd
COPY ipsec-assist.sh /etc/init.d/ipsec-assist
COPY start_vpn.sh /usr/bin/start_vpn.sh

EXPOSE 500/udp 4500/udp 1701/udp

CMD /usr/bin/start_vpn.sh
