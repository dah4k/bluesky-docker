all:
	docker build --file Dockerfile --tag bluesky .

test: all
	xhost +local:dummy
	docker run -it --init --rm \
		--network=host \
		--env DISPLAY=${DISPLAY} \
		--volume ${PWD}/persistent_cache:/bluesky/cache \
		--volume ${PWD}/src/bluesky:/bluesky \
		bluesky
	xhost -local:dummy

clean:
	docker rmi bluesky
	rm -f persistent_cache/*
	xhost -local:dummy

distclean:
	docker image prune --force
	docker system prune --force

_SUBMODULE_CANARY := src/bluesky/requirements-gui.txt
$(_SUBMODULE_CANARY):
	git submodule update --recursive --init src/bluesky

all: $(_SUBMODULE_CANARY)

.PHONY: all test clean distclean
