# apt-update-push

This is a small script to send push notifications to your phone after every system upgrade on Debian(-derivative) server systems.
This is mostly useful if you have `unattended-upgrades` installed and enabled, as it doesn't run if upgrade is done from a terminal.

It requires you to have the [ntfy app](https://ntfy.sh) installed on your phone (available from F-Droid as well).
On the server side of things, you need two things: `curl` and `needrestart`.

To install it, just clone the repository and run the install script:

```console
$ git clone https://github.com/theanonymousexyz/apt-update-push.git
$ sudo ./install.sh
```

It will prompt you to enter your "topic" for ntfy, but there's also the possibility to put it inside a `.env` (in the same directory as the installer) file like so:

```sh
# .env
topic="your-topic-here"
```
