# pyCARL 2

C++ and python go together like peanut butter and jelly. That's why we use SWIG to make carlsim's fast C++/CUDA code available in python3. We're currently working on making more of the C++ codebase available in pyCARL (e.g. LIF neurons, compartments, etc).
 
### Installation: 
 
```pip install -i https://test.pypi.org/simple/ carlsim``` 

### Getting Started:

Run a <i>hello world</i> program using a [colab notebook](https://github.com/bainro/autoCARL/blob/main/pyCARL/hello_world.ipynb).

### pyCARL 1
 
pyCARL 1 was built for a specific version of PyNN. pyCARL 2 extends the SWIG bindings, but foregos PyNN support at this time. To reference pyCARL 1's source code, please visit [CARLsim5](https://github.com/UCI-CARL/CARLsim5/tree/master/pyCARL). The original pyCARL 1 paper is [here](https://arxiv.org/abs/2003.09696).
