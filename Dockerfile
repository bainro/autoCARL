# Build image from this file: docker build - < Dockerfile
# install docker on ubuntu 22.04: https://github.com/docker/docker-install

# can install cuda on ubuntu22.04 by following instructions here:
# https://gist.github.com/MihailCosmin/affa6b1b71b43787e9228c25fe15aeba
# skip 'Install cuDNN' and everything after. test with 'nvcc -V'

# docker pull nvidia/cuda:11.8.0-devel-ubuntu22.04
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04
#FROM nvidia/cuda:11.8.0-devel-ubuntu20.04
#FROM nvidia/cuda:11.8.0-devel-ubuntu18.04

# Prevent stop building ubuntu at time zone selection.  
ENV DEBIAN_FRONTEND=noninteractive

# Prepare and empty machine for building.
RUN apt-get update && apt-get install -y git wget python3.10 python3.10-dev swig twine zip unzip

# create symlink for cmake to find old cuda samples' helper_cuda.h, etc
RUN wget https://github.com/NVIDIA/cuda-samples/archive/refs/tags/v11.8.zip 
RUN unzip v11.8.zip -d /cuda_samples
RUN mkdir -p /usr/local/cuda/samples/common/inc
RUN ln -s /cuda_samples/Common /usr/local/cuda/samples/common/inc

ARG CMAKE_VERSION=3.21.0
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh
ENV PATH="/usr/bin/cmake/bin:${PATH}"

RUN git clone https://github.com/bainro/autoCARL.git /output/carlsim
RUN mkdir /output/carlsim/build 
RUN cd /output/carlsim/build && cmake -DCMAKE_INSTALL_PREFIX=/tmp/_carlsim \
                                    -DCMAKE_BUILD_TYPE=Release .. \
                                    -DCARLSIM_NO_CUDA=OFF \
                                    -DCARLSIM_TEST=OFF \
                                    -DCARLSIM_PYCARL=ON \
                                    -DCARLSIM_BENCHMARKS=ON \
                                    -DCARLSIM_SHARED=OFF \
                                    -DCARLSIM_STATIC=ON
                                    # @TODO USE THIS FLAG INSTEAD!
                                    # -DCARLSIM_GH_ACTIONS=ON 
RUN cd /output/carlsim/build && make -j$(nproc) install
RUN zip -r /tmp/binaries.zip /tmp/_carlsim
# install python3 module for docker image when in interactive bash mode
# RUN cp pyCARL/carlsim.py /usr/lib/python3.8 && cp pyCARL/_pycarl.so /usr/lib/python3.8
RUN cd /output/carlsim/pyCARL && python3 setup.py sdist
