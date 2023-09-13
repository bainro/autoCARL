#!/bin/bash
rm -fr build
mkdir build
cd ./build && rm -fr ./*
cmake -DCMAKE_INSTALL_PREFIX=/tmp/autoCARL \
      -DCMAKE_BUILD_TYPE=Release .. \ # Debug .. \
      -DCARLSIM_NO_CUDA=OFF \
      -DCARLSIM_TEST=OFF \
      -DCARLSIM_PYCARL=OFF \
      -DCARLSIM_BENCHMARKS=ON \
      -DCARLSIM_SHARED=OFF \
      -DCARLSIM_STATIC=ON \
      --trace \
      --debug-output || cd .. 
make -j8 install VERBOSE=1 || cd ..

### PRINT ALL CMAKE VAR'S
#get_cmake_property(_variableNames VARIABLES)
#list (SORT _variableNames)
#foreach (_variableName ${_variableNames})
#    message(STATUS "${_variableName}=${${_variableName}}")
#endforeach()
