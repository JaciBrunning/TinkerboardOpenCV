#!/bin/bash

# WARNING: You should only run this in a docker container, it's potentially poisonous to your /usr/local.

# Install Tinkerboard Toolchain
curl -SL https://github.com/JacisNonsense/TinkerboardGCC/releases/download/20181227.8/Tinkerboard-Linux-Toolchain-6.3.0.tar.gz | sh -c 'mkdir -p /usr/local && cd /usr/local && tar xzf - --strip-components=1'

# export PATH=/tmp/tinkerboard-toolchain:$PATH
# echo $PATH

# Clone, patch and build thirdparty-opencv from wpilib
git clone --recurse-submodules --depth=1 --shallow-submodules https://github.com/wpilibsuite/thirdparty-opencv.git
pushd thirdparty-opencv
git apply ../tinkerboard.patch
./gradlew publish -Pplatform=linux-tinkerboard
popd