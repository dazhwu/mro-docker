.PHONY : docker-build

docker-build: 3.5.1/Dockerfile
	@docker build \
	--build-arg VCS_URL=$(VCS_URL) \
	--build-arg VCS_REF=$(VCS_REF) \
	--build-arg BUILD_DATE=$(BUILD_DATE) 3.5.1/
