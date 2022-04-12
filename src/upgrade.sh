#!/bin/sh

TOPIC="REPLACE_TOPIC"
TITLE="Host '$(uname -n)' has been upgraded"
NO_UPGRADES="No packages found that can be upgraded unattended"

unattended-upgrades -v >/etc/upgrade-status.log 2>&1
STATUS=$?

if grep -Fq "$NO_UPGRADES" /etc/upgrade-status.log; then
    rm -f /etc/upgrade-status.log
    exit 0
fi

if [ $STATUS -gt 0 ]; then
    TITLE="Warning: Host '$(uname -n)' failed upgrading"
    MSG="Something went wrong!"
    TAGS="warning"
elif [ -f /var/run/reboot-required ]; then
    MSG="Reboot required"
    TAGS="o"
elif needrestart -b | grep -q "NEEDRESTART-SVC"; then
    MSG="Some services need to be restarted"
    TAGS="large_orange_diamond"
else
    MSG="Nothing needs to be done"
    TAGS="white_check_mark"
fi

curl -X 'POST' \
    -H "Title: $TITLE" \
    -H "Tags: $TAGS" \
    -d "$MSG" \
    "https://ntfy.sh/$TOPIC"

rm -f /etc/upgrade-status.log
