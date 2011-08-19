#!/bin/bash
#
# package_zips.sh
#
#
# 2011 nubecoder
# http://www.nubecoder.com/
#

#defines
BINARY_PATH="$PWD/installer-zip/files/system/bin/"

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
REMOVE_ZIP_BINARY()
{
	rm -f "$BINARY_PATH/bash"
}
PREPARE_FOLDER()
{
	REMOVE_ZIP_BINARY
	cp "$PWD/$1" "$BINARY_PATH/bash"
}
CREATE_ZIP()
{
	local T1=$(date +%s)
	NAME="android_$1"
	echo "Begin $NAME creation..."
	PREPARE_FOLDER "$NAME"
	OUTFILE=$PWD/$NAME"_installer.zip"
	rm -fr "$OUTFILE"
	MKZIP='7z -mx9 -mmt=1 a "$OUTFILE" .'
	pushd "installer-zip" > /dev/null
		eval "$MKZIP" > /dev/null
	popd > /dev/null
	local T2=$(date +%s)
	echo "$NAME creation took $(($T2 - $T1)) seconds."
}

#main
START_SCRIPT

SPACER
echo "Packaging bash-3.2"
VERSION="bash-3.2.51(2)"
CREATE_ZIP "$VERSION"

SPACER
echo "Packaging bash-4.0"
VERSION="bash-4.0.38(2)"
CREATE_ZIP "$VERSION"

SPACER
echo "Packaging bash-4.1"
VERSION="bash-4.1.11(2)"
CREATE_ZIP "$VERSION"

SPACER
REMOVE_ZIP_BINARY
SHOW_COMPLETED

