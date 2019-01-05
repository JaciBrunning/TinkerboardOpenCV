#!/bin/bash

git clone --recurse-submodules --depth=1 --shallow-submodules https://github.com/wpilibsuite/allwpilib.git

pushd allwpilib
git apply ../wpi.patch

# Shared
mkdir buildShared; pushd buildShared
cmake -DWITHOUT_ALLWPILIB=1 -DWITHOUT_JAVA=1 -DCMAKE_TOOLCHAIN_FILE=../arm-tinkerboard-gnueabihf.toolchain.cmake \
      -DOpenCV_DIR=../../thirdparty-opencv/buildShared/linux-tinkerboard/ \
      -DBUILD_SHARED_LIBS=1 \
      ..
make -j4
popd

# SharedDebug
mkdir buildSharedDebug; pushd buildSharedDebug
cmake -DWITHOUT_ALLWPILIB=1 -DWITHOUT_JAVA=1 -DCMAKE_TOOLCHAIN_FILE=../arm-tinkerboard-gnueabihf.toolchain.cmake \
      -DOpenCV_DIR=../../thirdparty-opencv/buildSharedDebug/linux-tinkerboard/ \
      -DBUILD_SHARED_LIBS=1 \
      -DCMAKE_BUILD_TYPE=Debug \
      ..
make -j4
popd

# Static
mkdir buildStatic; pushd buildStatic
cmake -DWITHOUT_ALLWPILIB=1 -DWITHOUT_JAVA=1 -DCMAKE_TOOLCHAIN_FILE=../arm-tinkerboard-gnueabihf.toolchain.cmake \
      -DOpenCV_DIR=../../thirdparty-opencv/build/linux-tinkerboard/ \
      -DBUILD_SHARED_LIBS=0 \
      ..
make -j4
popd

# StaticDebug
mkdir buildStaticDebug; pushd buildStaticDebug
cmake -DWITHOUT_ALLWPILIB=1 -DWITHOUT_JAVA=1 -DCMAKE_TOOLCHAIN_FILE=../arm-tinkerboard-gnueabihf.toolchain.cmake \
      -DOpenCV_DIR=../../thirdparty-opencv/buildDebug/linux-tinkerboard/ \
      -DBUILD_SHARED_LIBS=0 \
      -DCMAKE_BUILD_TYPE=Debug \
      ..
make -j4
popd

popd

pushd wpilib_publish
./gradlew clean publish
popd
