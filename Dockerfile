FROM ubuntu:xenial
MAINTAINER Fan Zhang <bl4ck5unxx@gmail.com>

ARG SGX_DRIVER_URL=https://download.01.org/intel-sgx/linux-2.1.2/ubuntu64-desktop/sgx_linux_x64_driver_1bf506e.bin
ARG SGX_PSW_URL=https://download.01.org/intel-sgx/linux-2.1.2/ubuntu64-desktop/sgx_linux_x64_psw_2.1.102.43402.bin
ARG SGX_SDK_URL=https://download.01.org/intel-sgx/linux-2.1.2/ubuntu64-desktop/sgx_linux_x64_sdk_2.1.102.43402.bin

RUN apt-get -qq update
RUN apt-get -qq install -y build-essential automake autoconf \
    cmake \
    libssl-dev libcurl3-openssl-dev \
    libprotobuf-dev \
    linux-headers-$(uname -r) \
    kmod \
    wget

RUN mkdir /root/sgx

WORKDIR /root/sgx

RUN wget -qO sgx_linux_driver.bin $SGX_DRIVER_URL && \
    wget -qO sgx_linux_psw.bin $SGX_PSW_URL && \
    wget -qO sgx_linux_sdk.bin $SGX_SDK_URL && \
    chmod +x sgx_linux_driver.bin && \
    chmod +x sgx_linux_psw.bin && \
    chmod +x sgx_linux_sdk.bin && \
    ./sgx_linux_driver.bin && \
    ./sgx_linux_psw.bin && \
    echo -e 'no\n/opt/intel' | ./sgx_linux_sdk.bin && \
    echo 'source /opt/intel/sgxsdk/environment' >> /root/.bashrc
