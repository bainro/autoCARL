#!/bin/bash
mkdir build
cd ./build && rm -fr ./*
cmake -DCMAKE_INSTALL_PREFIX=/tmp/autoCARL \
      -DCMAKE_BUILD_TYPE=Release .. \
      -DCARLSIM_NO_CUDA=OFF \
      -DCARLSIM_TEST=YES \
      -DCARLSIM_PYCARL=ON \
      -DCARLSIM_SHARED=ON \
      -DCARLSIM_STATIC=OFF || cd .. # \--trace \--debug-output
make -j8 install || cd ..
