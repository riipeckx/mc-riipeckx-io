.DEFAULT_GOAL := help

# Vars
JEKYLL_IMAGE=jekyll/jekyll:3.8
CONTAINER_NAME=jekyll

help: # Print this help message
	@grep -E '^[a-zA-Z0-9_]+:.*#.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*#"} {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

start: # Start the development server
	@docker run -d --rm --workdir=/srv/jekyll -p 4000:4000 -v ./:/srv/jekyll --name $(CONTAINER_NAME) $(JEKYLL_IMAGE) sh -c "bundle install && jekyll serve --trace" &>/dev/null
	@echo "Container $(CONTAINER_NAME) started..."

stop: # Stop the development container
	@docker rm -f $(CONTAINER_NAME) &>/dev/null
	@echo "Container $(CONTAINER_NAME) stopped and removed..."

shell: # Open a shell in the development container
	@docker exec -it $(CONTAINER_NAME) sh

startup-shell: # Open a shell in the development container
	@docker run -it --rm --entrypoint=/bin/sh --workdir=/srv/jekyll -p 4000:4000 -v ./:/srv/jekyll --name $(CONTAINER_NAME)-shell $(JEKYLL_IMAGE)

logs: # Print and follow development container logs
	@docker logs -f $(CONTAINER_NAME)

clean: # Remove builded site
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	@rm -r _site .jekyll-cache &>/dev/null