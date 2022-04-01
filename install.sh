#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

[[ -f .env ]] && source .env
[[ -z $topic ]] && { echo -n "Enter your topic for https://ntfy.sh: "; read topic; }

cp -fv src/ntfy.sh /etc/ntfy.sh
cp -fv src/push-notifier /etc/apt/apt.conf.d/80push-notifier

chmod +x /etc/ntfy.sh
chmod +x /etc/apt/apt.conf.d/80push-notifier

sed -i "s/REPLACE_TOPIC/$topic/g" /etc/ntfy.sh

echo "Installed!"
