#!/bin/bash

# install shadowsocks-libv
sudo apt update 
sudo apt install -y shadowsocks-libev
PORT=$(jq -r '.server_port' /etc/shadowsocks-libev/config.json)
PASSWORD=$(jq -r '.password' /etc/shadowsocks-libev/config.json)
METHOD=$(jq -r '.method' /etc/shadowsocks-libev/config.json)
nohup shadow-tls --fastopen --v3 --strict server --listen 0.0.0.0:1443 --server 127.0.0.1:$PORT --tls  gateway.icloud.com --password $PASSWORD > shadow-tls.log 2>&1 &
echo "$(curl -s ipinfo.io/city) = ss, $(curl -s ipinfo.io/ip), 1443, encrypt-method=$METHOD, password=$PASSWORD ,shadow-tls-password=$PASSWORD, shadow-tls-sni=gateway.icloud.com, shadow-tls-version=3"

