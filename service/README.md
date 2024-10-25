# OpenRC service

OpenRC is a dependency-based init system that works with the
system-provided init program, normally `/sbin/init`.

## Setup

### Requirements

* `rcon`

In order to setup provided [mc-riipeckx-io](./mc-riipeckx-io) OpenRC service, follow this :

_All commands must be run as root_

### Create symlink in `/etc/init.d`

```shell
ln -s "$PWD"/mc-riipeckx-io /etc/init.d/mc-riipeckx-io
```

### Add service to `boot` level

```shell
rc-update add mc-riipeckx-io default
```

### Start the service now

```shell
rc-service mc-riipeckx-io start
```

### Get the service status

```shell
rc-service mc-riipeckx-io status
```
