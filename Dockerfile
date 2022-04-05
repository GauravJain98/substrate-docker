FROM ubuntu:20.04
LABEL name="Gaurav Jain"
LABEL maintainer="https://github.com/GauravJain98"


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

COPY . /substrate-node
WORKDIR /substrate-node

RUN cargo clean
RUN cargo build --release

WORKDIR /substrate-node/target/release
# Expose ports
EXPOSE 9944

# WORKDIR /substrate-node/target/release
# # Expose ports
# EXPOSE 9944