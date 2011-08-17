#!/bin/bash
#
# build_bash_arm.sh
#
#
# 2011 nubecoder
# http://www.nubecoder.com/
#

TOOLCHAIN="arm-2011.03-41"
#TOOLCHAIN="arm-2010.09-50"
#TOOLCHAIN="arm-2009q3-67"
export CC="/home/nubecoder/android/kernel_dev/toolchains/$TOOLCHAIN/bin/arm-none-linux-gnueabi-gcc"
export CFLAGS="-g -O2 -static"

# variables
CC_STRIP="/home/nubecoder/android/kernel_dev/toolchains/$TOOLCHAIN/bin/arm-none-linux-gnueabi-strip"

# defaults
THREADS=$(expr 1 + $(grep processor /proc/cpuinfo | wc -l))
VERBOSE="n"
ERROR_MSG=

#functions
SPACER()
{
	echo "*"
}
START_SCRIPT()
{
	TIME_START=$(date +%s)
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
}
SHOW_COMPLETED()
{
	echo "Script completed."
	TIME_END=$(date +%s)
	echo "Total time: $(($TIME_END - $TIME_START)) seconds."
	SPACER
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	exit
}
FATAL_ERROR()
{
	if [ -n "$ERROR_MSG" ] ; then
		echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
		echo "$ERROR_MSG"
		SHOW_COMPLETED
	fi
}
MAKE_DISTCLEAN()
{
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	local T1=$(date +%s)
	echo "Begin make distclean for $1..." && echo ""
	rm -f arm_"$1"_stripped
	pushd $1 > /dev/null
		if [ "$VERBOSE" = "y" ] ; then
			make V=1 distclean 2>&1 | tee bash.distclean.out
		else
			make distclean 2>&1 >bash.distclean.out
		fi
#		rm -f Makefile
	popd > /dev/null
	local T2=$(date +%s)
	echo "" && echo "make distclean for $1 took $(($T2 - $T1)) seconds."
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	SPACER
}
RUN_CONFIGURE()
{
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	local T1=$(date +%s)
	echo "Begin configure for $1..." && echo ""
	pushd $1 > /dev/null
		if [ "$VERBOSE" = "y" ] ; then
			sh configure --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi --target=arm-none-linux-gnueabi --enable-static-link --without-bash-malloc 2>&1 | tee bash.configure.out
		else
			sh configure --build=i686-pc-linux-gnu --host=arm-none-linux-gnueabi --target=arm-none-linux-gnueabi --enable-static-link --without-bash-malloc 2>&1 >bash.configure.out
		fi
	popd > /dev/null
	local T2=$(date +%s)
	echo "" && echo "Configure for $1 took $(($T2 - $T1)) seconds."
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	SPACER
}
STRIP_BASH()
{
	if [ -f bash ] ; then
		echo "Bash found, stripping for size..."
		VERSION=$(strings bash | egrep -Ei '^.+Bash\sversion\s.+' | egrep -oEi '[0-9]+\.[0-9]+\.[0-9]+\([0-9]+\)')
		cp -f bash android_bash-"$VERSION"
		$CC_STRIP -d --strip-unneeded android_bash-"$VERSION"
		mv -f android_bash-"$VERSION" ../android_bash-"$VERSION"
	else
		ERR_MSG="ERROR:: Bash was not found!"
		FATAL_ERROR
	fi
}
BUILD_BASH()
{
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	local T1=$(date +%s)
	echo "Begin building $1..." && echo ""
	pushd $1 > /dev/null
		if [ "$VERBOSE" = "y" ] ; then
			make V=1 -j"$THREADS" 2>&1 | tee bash.make.out
		else
			make -j"$THREADS" 2>&1 >bash.make.out
		fi
		STRIP_BASH
	popd > /dev/null
	local T2=$(date +%s)
	echo "" && echo "Building $1 took $(($T2 - $T1)) seconds."
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	SPACER
}
DO_ALL()
{
	echo "building $1"
	SPACER
	MAKE_DISTCLEAN "$1"
	RUN_CONFIGURE "$1"
	BUILD_BASH "$1"
	SPACER
}

# main
START_SCRIPT
DO_ALL "bash-3.2"
DO_ALL "bash-4.0"
DO_ALL "bash-4.1"
SHOW_COMPLETED

