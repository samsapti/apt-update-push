#!/bin/sh

[ -t 1 ] && exit 0  # exit if stdout is a terminal

TOPIC="REPLACE_TOPIC"

if [ -f /var/run/reboot-required ]; then
    MSG="Reboot required!"
    TAGS="warning"
elif needrestart -b | grep -q "NEEDRESTART-SVC"; then
    MSG="Some services need to be restarted!"
    TAGS="exclamation"
else
    MSG="Nothing needs to be done!"
    TAGS="grey_exclamation"
fi

curl -X 'POST' \
    -H "Title: Host '$(uname -n)' has been upgraded" \
    -H "Tags: $TAGS" \
    -d "$MSG" \
    "https://ntfy.sh/$TOPIC"
