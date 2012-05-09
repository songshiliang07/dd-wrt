#!/bin/bash

SCRIPT_NAME=./build-firmware.sh
echo $0
if test $0 != $SCRIPT_NAME; then
	echo please run it as $SCRIPT_NAME.
	exit -1
fi

if test -z $TOOLCHAIN; then
	echo set default toolchain
	TOOLCHAIN=toolchain-mipsel_4.1.1_BRCM24
fi

CURRENT_DIR=`pwd`
TOOLCHAIN_DIR=$CURRENT_DIR/$TOOLCHAIN
GLIB_DIR=$CURRENT_DIR/mipsel-linux/glib
TARGET_DIR=$CURRENT_DIR/dd-wrt.v24_std_generic

echo $CURRENT_DIR
echo $TOOLCHAIN_DIR
echo $GLIB_DIR
echo $TARGET_DIR

PATH=$TOOLCHAIN_DIR/bin:$PATH

cd firmware-mod-kit/trunk
./build_firmware.sh $CURRENT_DIR/custom_firmware $TARGET_DIR
cd ../..

