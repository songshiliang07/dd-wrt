#!/bin/bash

GLIB=`pwd`/mipsel-linux/glib
NOCATSPLASH=`pwd`/mipsel-linux/nocatsplash
if test $# != 0; then
	NOCATSPLASH=$1
fi

echo $GLIB
echo $NOCATSPLASH

rm -rf glib-1.2.10/
tar zxfP glib-1.2.10.tar.gz
cd glib-1.2.10/
patch < ../0001-compile-error.patch
./configure --prefix=$GLIB --build=mipsel-linux --host=mipsel-linux --disable-shared --enable-static
make CC=mipsel-linux-uclibc-gcc LD=mipsel-linux-uclibc-ld install
cd ..

cd NoCatSplash-0.92
make clean
./configure --prefix=$NOCATSPLASH --build=mipsel-linux --host=mipsel-linux --disable-glibtest --disable-shared --enable-static --with-glib-prefix=$GLIB
make CC=mipsel-linux-uclibc-gcc LD=mipsel-linux-uclibc-ld install
cd ..

