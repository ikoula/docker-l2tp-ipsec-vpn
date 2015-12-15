# Docker L2TP / IPSec VPN Client

Based on Ubuntu Trusty Docker image with x2ltpd (Open Source implementation of the L2TP tunneling protocol) and Strongswan (IPsec VPN solution).

Use this image to connect to a StrongSwann IPSEC / L2TP remote server with PSK authentication.

This Docker image uses the follogwing four environment variables that can be declared in a env file :
```ini
VPN_SERVER_IP=<IPv4 of your VPN server>
PSK=<pre shared key>
USER=<USERNAME>
PASS=<PASSWORD>
```

## Usage
You can run your Docker container with the following command (change "./vpn.env" with your own env file) :

```shell
docker run \
    --name docker-l2tp-ipsec-client-vpn \
    --cap-add NET_ADMIN \
    -d \
    --env-file ./vpn.env \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -p 1701:1701/udp \
    ikoula/docker-l2tp-ipsec-vpn
```

To check the status of your VPN Ipsec status you can pass "ipsec status" to your container like this :

```shell
docker exec -it docker-l2tp-ipsec-client-vpn ipsec status
Security Associations (1 up, 0 connecting):
l2tp-psk-client[1]: ESTABLISHED 54 seconds ago, 172.17.0.2[172.17.0.2]...X.X.X.X[X.X.X.X]
l2tp-psk-client{1}:  INSTALLED, TUNNEL, ESP in UDP SPIs: cd481d59_i cc19aba5_o
l2tp-psk-client{1}:   172.17.0.2/32[udp/l2f] === X.X.X.X/32[udp/l2f]
```

## Building command
```shell
docker build -t ikoula/docker-l2tp-ipsec-vpn:v0.12 docker-l2tp-ipsec-vpn
```
