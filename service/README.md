# OpenRC service

OpenRC is a dependency-based init system that works with the
system-provided init program, normally `/sbin/init`.

## Setup

### Requirements

* `rcon`

In order to setup provided [minecraft](./minecraft) OpenRC service, follow this :

_All commands must be run as root_

### Create symlink in `/etc/init.d`

```shell
➜ ln -s "$PWD"/minecraft /etc/init.d/minecraft-servers
```

### Add service to `boot` level

```shell
rc-update add minecraft-servers default
```

### Start the service now

```shell
rc-service minecraft-servers start
```