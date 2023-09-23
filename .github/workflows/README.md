## Automatic binary builds, python distribution upload, and tests.

The binaries_and_pypi.yml workflow assumes that the self-hosted runner has the following dependencies:
- nvidia-drivers
- cuda toolkit 11.x
- docker
- nvidia-docker-toolkit
- twine

The build.yml workflow runs tests and uploads code coverage reports to coveralls.io. It has the following dependencies:
- nvidia-drivers
- cuda toolkit 11.x
- lcov
- cmake
