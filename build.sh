#!/bin/bash

SCRIPT_NAME=./build.sh
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

cd NoCatSplash-0.92
make clean
# 配置
./configure --target=mipsel-linux --disable-shared --enable-static --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/lib --sysconfdir=/etc --datadir=/usr/share --localstatedir=/var --mandir=/usr/man --infodir=/usr/info --with-mode=open --with-remote-splash --with-firewall=iptables --with-docroot=/www --disable-glibtest --with-glib-prefix=$GLIB_DIR
# 编译
make CC=mipsel-linux-uclibc-gcc LD=mipsel-linux-uclibc-ld CFLAGS="-I$GLIB_DIR/include -DHAVE_LIBGHTTP -g -O2" LIBS="-L$GLIB_DIR/lib -lglib -lghttp"
# 安装到固件工作目录的合适位置
/usr/bin/install -c -v -s --strip-program=$TOOLCHAIN_DIR/bin/mipsel-linux-uclibc-strip src/splashd $TARGET_DIR/rootfs/usr/sbin/splashd
cd ..

