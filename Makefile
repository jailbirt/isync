help:
	@echo "Options:"
	@echo "    build-image: build the docker image of isync"

build-image:
	docker build --rm -t bcouto/isync .
