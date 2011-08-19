#!/bin/bash
#
# download_and_patch_bash.sh
#
#
# 2011 nubecoder
# http://www.nubecoder.com/
#

#functions
SPACER()
{
	echo "*"
}
START_SCRIPT()
{
	TIME_START=$(date +%s)
	echo "=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]=]"
	SPACER
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
DOWNLOAD_AND_PATCH_BASH()
{
	echo "Working on $1..."
	SPACER
	if [ -d "$1" ] ; then
		rm -rf "$1"
	fi
	SPACER
	wget http://ftp.gnu.org/gnu/bash/$1.tar.gz{,.sig} >/dev/null 2>&1
	SPACER
	# Import public key of bash author, Chet Ramey
	wget -O- http://tiswww.case.edu/php/chet/gpgkey.asc >/dev/null 2>&1 | gpg --import >/dev/null 2>&1
	SPACER
	# Verify signature
	gpg $1.tar.gz.sig >/dev/null 2>&1
	SPACER
	# Download and verify patches and signatures
	for i in {1..999} ; do
		wget http://ftp.gnu.org/gnu/bash/$1-patches/$2-$(printf "%03d" $i){,.sig} >/dev/null 2>&1 || break
		gpg $2-$(printf "%03d" $i).sig >/dev/null 2>&1 || exit
	done
	SPACER
	# Untar bash
	tar xvzf $1.tar.gz >/dev/null 2>&1
	SPACER
	# Apply patches
	pushd $1 > /dev/null
		cat ../$2-??? | patch -p0 >/dev/null 2>&1
		SPACER
	popd > /dev/null
	# Clean up files
	find . -type f -name "$2-*" -exec rm -f {} \;
	rm -f $1.tar*
	SPACER
	echo "Finished with $1..."
	SPACER
}

#main
START_SCRIPT
DOWNLOAD_AND_PATCH_BASH "bash-3.2" "bash32"
DOWNLOAD_AND_PATCH_BASH "bash-4.0" "bash40"
DOWNLOAD_AND_PATCH_BASH "bash-4.1" "bash41"
SHOW_COMPLETED

