FROM ubuntu:20.04
LABEL name="Gaurav Jain"
LABEL maintainer="https://github.com/GauravJain98"
ENV TZONE=Asia/Kolkata
ENV LANG=en_IN.UTF-8
ENV LANGUAGE en_IN
RUN ln -snf /usr/share/zoneinfo/$TZONE /etc/localtime && echo $TZONE > /etc/timezone


# Install build dependencies
RUN apt-get update -y \
    && apt-get install -y automake \
    build-essential \
    apt-utils \
    curl \
    && apt-get clean

RUN mkdir -p /root/setup
WORKDIR /root/setup
RUN curl https://getsubstrate.io -sSf | bash -s -- --fast
ENV PATH=/root/.cargo/bin:$PATH
RUN cargo --version
RUN rustup update nightly & \
    rustup update stable &\
    rustup target add wasm32-unknown-unknown --toolchain nightly

RUN git clone https://github.com/substrate-developer-hub/substrate-node-template /substrate-node
WORKDIR /substrate-node

RUN cargo clean
RUN cargo build --release

WORKDIR /substrate-node/target/release
# Expose ports
EXPOSE 9944

# WORKDIR /substrate-node/target/release
# # Expose ports
# EXPOSE 9944