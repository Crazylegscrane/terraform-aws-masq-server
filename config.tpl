#!/bin/bash
apt update -y
apt install -y jq awscli
curl -so /usr/local/bin/MASQNode https://d1amsfh5awdbez.cloudfront.net/x86_64-unknown-linux-gnu/MASQNode
chmod 755 /usr/local/bin/MASQNode
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
arr=( $(curl -s https://nodes.masq.ai/api/v0/nodes | jq -r '.[].descriptor') )
printf -v joined '%s,' "$${arr[@]}"
echo "chain=\"${chain}\"" >> /home/ubuntu/config.toml
echo "blockchain-service-url=\"${bcsurl}\"" >> /home/ubuntu/config.toml
echo "clandestine-port=\"${clandestine_port}\"" >> /home/ubuntu/config.toml
echo "db-password=\"${dbpass}\"" >> /home/ubuntu/config.toml
echo "dns-servers=\"${dnsservers}\"" >> /home/ubuntu/config.toml
echo "earning-wallet=\"${earnwallet}\"" >> /home/ubuntu/config.toml
echo "gas-price=\"${gasprice}\"" >> /home/ubuntu/config.toml
echo "ip=\"$${ip}\"" >> /home/ubuntu/config.toml
echo "log-level=\"trace\"" >> /home/ubuntu/config.toml
echo "neighborhood-mode=\"standard\"" >> /home/ubuntu/config.toml
echo "real-user=\"1000:1000:/home/ubuntu\"" >> /home/ubuntu/config.toml
echo "neighbors=\"$${joined%,}\"" >> /home/ubuntu/config.toml
echo "consuming-private-key=\"${conkey}\"" >> /home/ubuntu/config.toml
/usr/local/bin/MASQNode --config-file /home/ubuntu/config.toml