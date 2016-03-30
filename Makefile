help:
	@echo "Options:"
	@echo "    build-image: build the docker image of ABcon"
	@echo "    clean: clean all stopped containers of ABcon"

build-image:
	docker build --rm -t bcouto/isync .
