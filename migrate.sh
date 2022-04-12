#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

rm -fv /etc/ntfy.sh
rm -fv /etc/apt/apt.conf.d/push-notifier

exec ./install.sh
