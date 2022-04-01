# apt-update-push

This is a small script to send push notifications to your phone after every system upgrade on Debian(-derivative) systems.
This is mostly useful if you have unattended upgrades enabled.

It requires you to have the [NTFY app](https://ntfy.sh) installed on your phone (available from F-Droid as well).

To install it, just run this command:

```bash
$ sudo bash install.sh
```

It will prompt you to enter your "topic" for NTFY, but there's also the possibility to put it inside a `.env` file like so:

```bash
# .env
topic="your-topic-here"
```
