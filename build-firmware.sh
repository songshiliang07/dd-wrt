#!/bin/bash

CURRENT_DIR=`pwd`
TOOLCHAINS=/workspace/workspace/DD-WRT_toolchains/toolchain-mipsel_3.3.6_BRCM24/bin
GLIB_DIR=$CURRENT_DIR/mipsel-linux/glib
TARGET_DIR=$CURRENT_DIR/dd-wrt.v24_std_generic

echo $CURRENT_DIR
echo $TOOLCHAINS
echo $GLIB_DIR
echo $TARGET_DIR

PATH=$TOOLCHAINS:$PATH

cd firmware-mod-kit/trunk
./build_firmware.sh $CURRENT_DIR/custom_firmware $TARGET_DIR
cd ../..

