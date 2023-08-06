FROM ubuntu:22.04

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
COPY src/bluesky/requirements-gui.txt /tmp/requirements-gui.txt
RUN pip install -r /tmp/requirements-gui.txt

WORKDIR /bluesky
ENTRYPOINT ["/usr/bin/python3", "BlueSky_pygame.py"]
CMD ["--scenfile", "/bluesky/scenario/demo.scn"]
