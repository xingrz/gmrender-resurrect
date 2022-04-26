# builder

FROM debian:bullseye AS builder

RUN apt-get update && \
    apt-get install -y build-essential autoconf automake libtool pkg-config \
    libglib2.0-dev libupnp-dev

RUN apt-get install -y libgstreamer1.0-dev \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav gstreamer1.0-alsa gstreamer1.0-pulseaudio

WORKDIR /project
COPY . /project

RUN ./autogen.sh && ./configure && make

# runtime

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y libglib2.0-0 libupnp13

RUN apt-get install -y libgstreamer1.0-0

COPY --from=builder /project/src/gmediarender /
ENTRYPOINT [ "/gmediarender" ]
