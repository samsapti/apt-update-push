# apt-update-push

This is a small script to send push notifications to your phone after every unattended upgrade on Debian(-derivative) server systems.

It requires you to have the [ntfy app](https://ntfy.sh) installed on your phone (available from F-Droid as well).
On the server side of things, you need three things: `curl`, `needrestart` and `unattended-upgrades`.

To install it, just clone the repository and run the install script:

```sh
$ git clone https://github.com/theanonymousexyz/apt-update-push.git
$ sudo ./install.sh
```

It will prompt you to enter your "topic" for ntfy, but there's also the possibility to put it inside a `.env` (in the same directory as the installer) file like so:

```sh
# .env
topic="your-topic-here"
```

As the script runs `unattended-upgrades` via a cronjob instead of the usual systemd timer, you need to have the following in your `/etc/apt/apt.conf.d/20auto-upgrades`:

```aptconf
APT::Periodic::Unattended-Upgrade "0";
```

