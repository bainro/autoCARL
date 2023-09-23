from distutils.core import setup
setup(
  name = 'carlsim',
  packages = ['carlsim'],
  version = '1.1.5',
  license='MIT',
  description = 'GPU-accelerated Spiking Neural Network Simulator!',
  author = 'Robert Bain',
  author_email = 'rbain18@gmail.com',
  url = 'https://github.com/bainro/autoCARL',
  keywords = ['SNN', 'spiking', 'computational', 'neuroscience'],
  install_requires=[], # we don't require any 3rd party python packages :)
  include_package_data=True,
  package_data={'': ['_pycarl.so']},
  classifiers=[
    'Development Status :: 5 - Production/Stable',
    'Intended Audience :: Education',
    'Topic :: Software Development :: Build Tools',
    'License :: OSI Approved :: MIT License',
    'Programming Language :: Python :: 3'
  ],
)
