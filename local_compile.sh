#!/bin/bash
rm -fr build
mkdir build
cd ./build && rm -fr ./*
cmake -DCMAKE_INSTALL_PREFIX=/tmp/autoCARL \
      -DCMAKE_BUILD_TYPE=Debug .. \ # Release .. \
      -DCARLSIM_TEST=ON 
      #-DCARLSIM_NO_CUDA=OFF \
      #-DCARLSIM_PYCARL=OFF \
      #-DCARLSIM_BENCHMARKS=ON \
      #-DCARLSIM_SHARED=ON \
      #-DCARLSIM_STATIC=OFF || cd .. 
      # --trace \
      # --debug-output 
# make -j8 install VERBOSE=1 || cd ..
make -j8 install || cd ..

# GCOV TESTING SUITE
# assumes we're in build/
if ! ./carlsim/test/carlsim-tests; then
   echo "tests failed :("
   exit 125
fi
if ! ./carlsim/test6/carlsim-tests6; then
   echo "tests failed :("
   exit 125
fi
lcov --directory ./ --capture --output-file ./code_coverage.lcov \
     -rc lcov_branch_coverage=1 && \
lcov --remove ./code_coverage.lcov -o ./code_coverage.lcov \
     '/usr/*' '/tmp/*' '/home/rbain/github/autoCARL/build/*' && \
#cat ../code_coverage.lcov

### PRINT ALL CMAKE VAR'S. 
# Useful for when CMAKE makes you want to die :) (ie debugging)
#get_cmake_property(_variableNames VARIABLES)
#list (SORT _variableNames)
#foreach (_variableName ${_variableNames})
#    message(STATUS "${_variableName}=${${_variableName}}")
#endforeach()
