## Automatic binary builds, python distribution upload, and tests.

The binaries_and_pypi.yml workflow assumes that the self-hosted runner has the following dependencies:
- twine
- docker
- nvidia-docker-toolkit
- nvidia-drivers
- cuda toolkit

The build.yml workflow runs tests and uploads code coverage reports to coveralls.io. It has the following dependencies:
- lcov
- nvidia-drivers
- cuda toolkit
