#!/bin/bash

CURRENT_DIR=`pwd`
TOOLCHAINS=$CURRENT_DIR/toolchain-mipsel_3.3.6_BRCM24/bin
GLIB_DIR=$CURRENT_DIR/mipsel-linux/glib
TARGET_DIR=$CURRENT_DIR/dd-wrt.v24_std_generic

echo $CURRENT_DIR
echo $TOOLCHAINS
echo $GLIB_DIR
echo $TARGET_DIR

PATH=$TOOLCHAINS:$PATH

rm -rf $GLIB_DIR

rm -rf glib-1.2.10/
tar zxfP glib-1.2.10.tar.gz
cd glib-1.2.10/
patch < ../0001-compile-error.patch
./configure --target=mipsel-linux --host=mipsel-linux --build=mipsel-linux --disable-shared --enable-static --prefix=$GLIB_DIR --includedir=$GLIB_DIR/include --libdir=$GLIB_DIR/lib
make CC=mipsel-linux-uclibc-gcc LD=mipsel-linux-uclibc-ld install
cd ..

rm -rf libghttp-1.0.9/
tar zxfP libghttp-1.0.9.tar.gz
cd libghttp-1.0.9/
./configure --target=mipsel-linux --host=mipsel-linux --build=mipsel-linux --disable-shared --enable-static --prefix=$GLIB_DIR --includedir=$GLIB_DIR/include --libdir=$GLIB_DIR/lib
make CC=mipsel-linux-uclibc-gcc LD=mipsel-linux-uclibc-ld install
cd ..

if test -d firmware-mod-kit; then
	echo firware-mod-kit directory exist...
	echo svn update...
	cd firmware-mod-kit
	svn up
	cd trunk/src
	./configure
	make
	cd ../..
	cd ..
else
	svn co http://firmware-mod-kit.googlecode.com/svn/trunk firmware-mod-kit
	cd firmware-mod-kit
	patch -p0 < ../firmware-mod-kit.patch
	cd trunk/src
	./configure
	make
	cd ../..
	cd ..
fi

if test -d $TARGET_DIR; then
	echo $TARGET_DIR directory exist...
	echo no need to extract firmware...
else
	cd firmware-mod-kit/trunk
	./extract_firmware.sh $CURRENT_DIR/dd-wrt.v24_std_generic.bin $TARGET_DIR
	cd ../..
fi

