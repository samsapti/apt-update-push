#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

[[ -z $topic ]] && { echo -n "Enter your topic for https://ntfy.sh: "; read topic; }

cp -v src/ntfy.sh /etc/ntfy.sh
cp -v src/push-notifier /etc/apt/apt.conf.d/80push-notifier

chmod +x /etc/ntfy.sh
chmod +x /etc/apt/apt.conf.d/80push-notifier

sed -i "s/REPLACE_TOPIC/$topic/g" 

echo "Installed!"
