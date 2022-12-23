#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

[[ -f .env ]] && source .env
[[ -z $topic ]] && read -rp "Enter your topic for https://ntfy.sh: " topic

cp -fv src/upgrade.sh /etc/upgrade.sh
sed -i "s/REPLACE_TOPIC/$topic/g" /etc/upgrade.sh
chmod +x /etc/upgrade.sh

read -rp "At what hour do you want the update to occur (enter value in 24 hour format, e.g. '21'): " hour
CRONJOB="0 $hour * * * /etc/upgrade.sh >/dev/null 2>&1"

if ! crontab -u root -l | grep -Fq "$CRONJOB"; then
    if crontab -u root -l >/dev/null 2>&1; then
        printf "%b" "$(crontab -u root -l)\n\n$CRONJOB\n" | crontab -u root -
    else
        echo "$CRONJOB" | crontab -u root -
    fi
fi

echo "Installed!"
