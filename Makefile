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
RCON=$(which rcon)
RCON_SRV=$(config_get server.ip)
RCON_PORT=$(config_get rcon.port)
RCON_PASS=$(config_get rcon.password)
RCON_CMD="$(RCON) -H ${RCON_SRV:-localhost} -p ${RCON_PORT} -P ${RCON_PASS}"

help: # Print this help message
	@grep -E '^[a-zA-Z0-9_]+:.*#.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*#"} {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

start: # Start the Minecraft server
	rc-service mc-riipeckx-io start

stop: # Stop the Minecraft server
	rc-service mc-riipeckx-io stop

status: # Get status from RCON
	rc-service mc-riipeckx-io status

console: # Send a command via RCON
	echo $(RCON_CMD) $(RUN_ARGS)