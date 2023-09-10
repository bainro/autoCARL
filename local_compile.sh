#!/bin/bash
rm -fr build
mkdir build
cd ./build && rm -fr ./*
cmake -DCMAKE_INSTALL_PREFIX=/tmp/autoCARL \
      -DCMAKE_BUILD_TYPE=Debug .. \ # Release .. \
      -DCARLSIM_NO_CUDA=OFF \
      -DCARLSIM_TEST=OFF \
      -DCARLSIM_PYCARL=OFF \
      -DCARLSIM_BENCHMARKS=OFF \
      -DCARLSIM_SHARED=OFF \
      -DCARLSIM_STATIC=ON \
      --VERBOSE=1 \
      --trace \
      --debug-output &> /tmp/bainro.log || cd ..
make -j8 install &>> /tmp/bainro.log || cd ..
