FROM nvidia/cuda:11.8.0-devel-ubuntu18.04

# create symlink for cmake to find host cuda's helper_cuda.h, etc
# expected to mount host volume using -v flag when launching container. Eg:
# docker run --gpus all -it -v /usr/local/cuda-11.1/samples:/tmp/host_cuda/samples <IMAGE_ID> bash
RUN ln -s /tmp/host_cuda/samples /usr/local/cuda/samples

# Prevent stop building ubuntu at time zone selection.  
ENV DEBIAN_FRONTEND=noninteractive

# Prepare and empty machine for building.
RUN apt-get update && apt-get install -y git wget python3.8 python3.8-dev swig

ARG CMAKE_VERSION=3.21.0
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh \
      -q -O /tmp/cmake-install.sh \
      && chmod u+x /tmp/cmake-install.sh \
      && mkdir /usr/bin/cmake \
      && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
      && rm /tmp/cmake-install.sh
ENV PATH="/usr/bin/cmake/bin:${PATH}"

RUN git clone https://github.com/bainro/autoCARL.git
RUN cd autoCARL && git checkout feat/PyCARL2 && ./local_compile.sh
# install python3 module for docker image
RUN cp pyCARL/carlsim.py /usr/lib/python3.8 && cp pyCARL/_pycarl.so /usr/lib/python3.8
