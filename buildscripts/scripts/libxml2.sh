#!/bin/bash -e

. ../../include/path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build$ndk_suffix
	exit 0
else
	exit 255
fi

[ -f configure ] || ./autogen.sh

mkdir -p _build$ndk_suffix
cd _build$ndk_suffix

extra=
[[ "$ndk_triple" == "i686"* ]] && extra="--disable-asm"

../configure \
	--host=$ndk_triple $extra \
	--enable-shared --disable-static \
	--disable-require-system-font-provider

make -j$cores
make DESTDIR="$prefix_dir" install
