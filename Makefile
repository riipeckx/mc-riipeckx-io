.DEFAULT_GOAL := help

# Vars
BASE=$(pwd)
SERVICE_NAME=mc-riipeckx-io
RCON_PASS=$(shell grep "rcon.password" server.properties | cut -d '=' -f 2)

ifeq (console,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

help: # Print this help message
	@grep -E '^[a-zA-Z0-9_]+:.*#.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*#"} {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

start: # Start Minecraft server
	@rc-service $(SERVICE_NAME) start

stop: # Stop Minecraft server
	@rc-service $(SERVICE_NAME) stop

status: # Get Minecraft server status
	@rc-service $(SERVICE_NAME) status

console: # Send a command using RCON
	@/usr/bin/rcon -H localhost -p 25575 -P $(RCON_PASS) $(RUN_ARGS)

output: # Follow the server logs
	@/usr/bin/tail -f ./logs/latest.log
