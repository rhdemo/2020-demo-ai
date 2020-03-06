##################################

# BUILD - build images locally using s2i

.PHONY: build
build:
	./install/build.sh

##################################

# PUSH - push images to repository

.PHONY: push
push:
	./install/push.sh