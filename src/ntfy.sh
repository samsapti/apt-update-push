#!/bin/sh

TOPIC="REPLACE_TOPIC"
SVC="$(needrestart -b)"

if [ -f /var/run/reboot-required ]; then
    MSG="Host '$(uname -n)' has been upgraded: Reboot required!"
elif echo "$SVC" | grep -q "NEEDRESTART-SVC"; then
    MSG="Host '$(uname -n)' has been upgraded: Some services need to be restarted!"
else
    MSG="Host '$(uname -n)' has been upgraded: Nothing needs to be done!"
fi

curl -X 'POST' -d "$MSG" "https://ntfy.sh/$TOPIC"
