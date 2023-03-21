#!/bin/sh -xe

here=$(dirname $(which $0))
ndkroot=$1
ndk=$ndkroot/toolchains/llvm/prebuilt/linux-x86_64/bin

cd ncurses-6.3
mkdir build.android
cd build.android
CC="$ndk/clang --target=aarch64-none-linux-android21" CXX="$ndk/clang++ --target=aarch64-none-linux-android21" ../configure --with-fallbacks=xterm-256color,vt100 --host=x86_64-pc-linux-gnu --build=aarch64-none-linux-android21 --prefix=$PWD/inst
make -j72 install
cd ../..

mkdir build.android
cd build.android
do_cmake() {
  cmake -GNinja -DCMAKE_TOOLCHAIN_FILE=$ndkroot/build/cmake/android.toolchain.cmake -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=29 -DWITH_GETTEXT=0 -DCURSES_INCLUDE_{PATH,DIRS}=$here/ncurses-6.3/build.android/inst/include -DCURSES_LIBRARIES=$here/ncurses-6.3/build.android/inst/lib/libncurses.a -DCMAKE_INSTALL_PREFIX=$PWD/inst -DCMAKE_{C,CXX}_FLAGS=--target=aarch64-none-linux-android29 ..
}
do_cmake
ninja install
