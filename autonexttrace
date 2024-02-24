#!/usr/bin/env bash

# Usage:
# bash <(curl -Lso- https://cdn.jsdelivr.net/gh/drzazi/scripts@main/autonexttrace.sh)
#!/bin/bash

ip_list=(122.143.8.41 123.172.127.217 111.27.127.176 202.198.16.25 2001:da8:b000::25)
ip_addr=(吉林联通 吉林电信 吉林移动 吉大教育网 吉大教育网v6)

# install nexttrace
if [ ! -f "/usr/local/bin/nexttrace" ]; then
  curl nxtrace.org/nt |bash
fi

for ((i=0; i<${#ip_list[@]}; i++)); do
    echo "${ip_addr[$i]}: ${ip_list[$i]}"
    nexttrace ${ip_list[$i]}
done

