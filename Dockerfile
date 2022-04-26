# builder

FROM debian:bullseye AS builder

RUN apt-get update && \
    apt-get install -y build-essential autoconf automake libtool pkg-config \
    libglib2.0-dev libupnp-dev

WORKDIR /project
COPY . /project

RUN ./autogen.sh && ./configure --without-gstreamer && make

# runtime

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y libglib2.0-0 libupnp13

COPY --from=builder /project/src/gmediarender /
ENTRYPOINT [ "/gmediarender" ]
