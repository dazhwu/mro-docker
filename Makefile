include 3.5.1/Makefile
.PHONY : docker-clean docker-prune docker-check

docker-clean :
	@echo Removing dangling/untagged images
	docker images -q --filter dangling=true | xargs docker rmi --force

docker-prune :
	@echo Pruning Docker images/containers not in use
	docker system prune -a

docker-check :
	@echo Computing reclaimable space consumed by Docker artifacts
	docker system df
