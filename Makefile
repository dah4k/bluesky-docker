all:
	docker build --file Dockerfile --tag bluesky .

test: all
	xhost local:dummy
	docker run -it --init --rm --network=host --env DISPLAY=${DISPLAY} bluesky

clean:
	docker image prune --force
	docker system prune --force

distclean: clean
	git submodule deinit --all

_SUBMODULE_CANARY := src/bluesky/requirements-gui.txt
$(_SUBMODULE_CANARY):
	git submodule update --recursive --init src/bluesky

all: $(_SUBMODULE_CANARY)

.PHONY: all test clean distclean
