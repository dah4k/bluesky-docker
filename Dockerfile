FROM ubuntu:22.04

WORKDIR /src
COPY src/bluesky /src/bluesky

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC
RUN apt-get update --quiet=2 --assume-yes --no-install-recommends \
    && apt-get install --quiet=2 --assume-yes --no-install-recommends \
        python3 \
        python3-pip \
        python3-pyside2.qtcore \
        python3-pyside2.qtwidgets \
        python3-tk \
        mesa-utils \
        x11-apps \
    && apt-get clean \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

## See Also https://github.com/TUDelft-CNS-ATM/bluesky/wiki/Installation
WORKDIR /src/bluesky
RUN pip install -r requirements-gui.txt

## `pip search` is dead garbage, use `pip_search` instead
RUN pip install pip-search

## WONTFIX: OpenGL.raw.GL import _errors. Fallback to Pygame renderer
ENTRYPOINT ["/usr/bin/python3", "BlueSky_pygame.py"]
