.PHONY : docker-clean docker-prune docker-check

VCS_URL := $(shell git remote get-url --push gh)
VCS_REF := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

docker-clean :
	@echo Removing dangling/untagged images
	docker images -q --filter dangling=true | xargs docker rmi --force

docker-prune :
	@echo Pruning Docker images/containers not in use
	docker system prune -a

docker-check :
	@echo Computing reclaimable space consumed by Docker artifacts
	docker system df

include 3.5.1/Makefile
