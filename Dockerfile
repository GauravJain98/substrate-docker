FROM ubuntu:20.04
LABEL name="Gaurav Jain"
LABEL maintainer="https://github.com/GauravJain98"


# Install build dependencies
RUN apt-get update -y \
    && apt-get install -y automake \
    build-essential \
    apt-utils \
    curl \`
    && apt-get clean

RUN mkdir -p /root/setup
WORKDIR /root/setup
RUN curl https://getsubstrate.io -sSf | bash -s -- --fast
ENV PATH=/root/.cargo/bin:$PATH
RUN cargo --version
RUN rustup update nightly & \
    rustup update stable &\
    rustup target add wasm32-unknown-unknown --toolchain nightly

RUN git clone -b v3.0.0 --depth 1 https://github.com/substrate-developer-hub/substrate-node-template /substrate-node
WORKDIR /substrate-node
RUN git checkout -b my-first-substrate-chain 
RUN cargo clean
RUN cargo test

# WORKDIR /substrate-node/target/release
# # Expose ports
# EXPOSE 9944