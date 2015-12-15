#!/bin/sh
IP_ADDRESS=`/sbin/ip -o -f inet a sh eth0 | awk '{print $4}' | cut -d "/" -f1`
: ${CONNEXION_NAME=l2tp-psk-client}
: ${VPN_REMOTE_SERVER=$VPN_SERVER_IP}
: ${PSKEY=$PSK}
: ${ACCOUNT_NAME=$USER}
: ${PASSWORD=$PASS}

sed -i "s/{VPN_CLIENT_IP}/$IP_ADDRESS/g" /etc/ipsec.conf
sed -i "s/{VPN_REMOTE_SERVER}/$VPN_REMOTE_SERVER/g" /etc/ipsec.conf /etc/ipsec.secrets /etc/xl2tpd/xl2tpd.conf
sed -i "s/{PSK}/$PSKEY/g" /etc/ipsec.secrets
sed -i "s/{ACCOUNT_NAME}/$ACCOUNT_NAME/g" /etc/ppp/chap-secrets /etc/xl2tpd/xl2tpd.conf
sed -i "s/{PASSWORD}/$PASSWORD/g" /etc/ppp/chap-secrets
sed -i "s/{CONNEXION_NAME}/$CONNEXION_NAME/g" /etc/init.d/ipsec-assist

echo "Disabling the XL2TP auto start..."

/usr/sbin/service xl2tpd stop

update-rc.d -f xl2tpd remove

echo "Adding the new auto start..."

update-rc.d ipsec-assist defaults

echo "Starting up the VPN..."

/usr/sbin/service ipsec-assist start

echo "Done."

tail -f /dev/null
