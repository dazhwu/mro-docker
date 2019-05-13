.PHONY : build-3.5.1 push-3.5.1

build-3.5.1: 3.5.1/Dockerfile
	@docker build \
	--build-arg VCS_URL=$(VCS_URL) \
	--build-arg VCS_REF=$(VCS_REF) \
	--build-arg BUILD_DATE=$(BUILD_DATE) \
	--tag blueogive/mro-docker:v3.5.1 \
	--tag blueogive/mro-docker:latest 3.5.1/

push-3.5.1 : build-3.5.1
	@docker push blueogive/mro-docker:v3.5.1
	@docker push blueogive/mro-docker:latest
	@docker push blueogive/mro-docker:$(TAG_DATE)
