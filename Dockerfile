FROM ubuntu:18.04
MAINTAINER Fan Zhang <bl4ck5unxx@gmail.com>

ARG SGX_SDK_URL=https://download.01.org/intel-sgx/sgx-linux/2.11/distro/ubuntu18.04-server/sgx_linux_x64_sdk_2.11.100.2.bin

RUN apt-get -qq update
RUN apt-get -qq install -y build-essential python bash wget git && \
    wget -qO sgx_linux_sdk.bin $SGX_SDK_URL && \
    chmod +x sgx_linux_sdk.bin && \
    echo -e 'no\n/opt/intel' | ./sgx_linux_sdk.bin && \
    echo 'source /opt/intel/sgxsdk/environment' >> /root/.bashrc && \
    git clone https://github.com/intel/intel-sgx-ssl ssl && \
    cd ssl && \
    git checkout lin_2.11_1.1.1g && \
    cd openssl_source && \
    wget -q https://www.openssl.org/source/openssl-1.1.1g.tar.gz && \
    cd ../Linux && \
    make sgxssl_no_mitigation && \
    make install && \
    apt-get remove --yes wget git && \
    apt-get --yes autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf *
