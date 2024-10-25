.DEFAULT_GOAL := help

define config_get()
  echo $(grep ${1} "${BASE}/server.properties" | cut -d '=' -f 2)
endef

ifeq (console,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

# Vars
BASE=$(pwd)
SERVICE_NAME=mc-riipeckx-io
RCON_SRV=$(config_get server.ip)
RCON_PORT=$(config_get rcon.port)
RCON_PASS=$(config_get rcon.password)

help: # Print this help message
	@grep -E '^[a-zA-Z0-9_]+:.*#.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*#"} {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

start: # Start the Minecraft server
	@rc-service $(SERVICE_NAME) start

stop: # Stop the Minecraft server
	@rc-service $(SERVICE_NAME) stop

status: # Get status from RCON
	@rc-service $(SERVICE_NAME) status

console: # Send a command via RCON
	/usr/bin/rcon -H $(RCON_SRV) -p $(RCON_PORT) -P $(RCON_PASS) $(RUN_ARGS)
