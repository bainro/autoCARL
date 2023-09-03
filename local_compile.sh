#!/bin/bash
mkdir build
cd ./build && rm -fr ./*
cmake -DCMAKE_INSTALL_PREFIX=/tmp/autoCARL \
      -DCMAKE_BUILD_TYPE=Release .. \
      -DCARLSIM_NO_CUDA=ON \
      -DCARLSIM_TEST=YES \
      -DCARLSIM_PYCARL=OFF \
      -DCARLSIM_SHARED=OFF \
      -DCARLSIM_STATIC=ON || cd .. # \--trace \--debug-output
make -j8 install || cd ..
