#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

[[ -f .env ]] && source .env
[[ -z $topic ]] && { echo -n "Enter your topic for https://ntfy.sh: "; read topic; }

CRONJOB="0 0 * * * /etc/upgrade.sh >/dev/null 2>&1"

cp -fv src/upgrade.sh /etc/upgrade.sh
sed -i "s/REPLACE_TOPIC/$topic/g" /etc/upgrade.sh
chmod +x /etc/upgrade.sh

if ! crontab -u root -l | grep -Fq "$CRONJOB"; then
    crontab -u root -l >/dev/null 2>&1 && CRONJOB="$(crontab -u root -l)\n\n$CRONJOB"

    echo "We're going to run unattended-upgrades via a cronjob instead of systemd."
    echo -n "Please choose 'no' on the next prompt. Press enter when you're ready" && read
    
    dpkg-reconfigure unattended-upgrades
    echo "$CRONJOB" | crontab -u root -
fi

echo "Installed!"
