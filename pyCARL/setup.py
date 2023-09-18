from distutils.core import setup
setup(
  name = 'carlsim',
  packages = ['carlsim'],
  version = '1.1.2',
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
    'Programming Language :: Python :: 3',
    'Programming Language :: Python :: 3.4',
    'Programming Language :: Python :: 3.5',
    'Programming Language :: Python :: 3.6',
    'Programming Language :: Python :: 3.7',
    'Programming Language :: Python :: 3.8',
    'Programming Language :: Python :: 3.9',
    'Programming Language :: Python :: 3.10',
    'Programming Language :: Python :: 3.11'
  ],
)
