#!/bin/bash

echo "Working on Bash 4.1..."
echo "**"
if [ -d "bash-4.1" ] ; then
    rm -rf "bash-4.1"
fi
echo "*"
wget http://ftp.gnu.org/gnu/bash/bash-4.1.tar.gz{,.sig} >/dev/null 2>&1
echo "*"
    # Import public key of bash author, Chet Ramey
wget -O- http://tiswww.case.edu/php/chet/gpgkey.asc >/dev/null 2>&1 | gpg --import >/dev/null 2>&1
echo "*"
    # Verify signature
gpg bash-4.1.tar.gz.sig >/dev/null 2>&1
echo "*"
    # Download and verify patches and signatures
for i in {1..999}; do
    wget http://ftp.gnu.org/gnu/bash/bash-4.1-patches/bash41-$(printf "%03d" $i){,.sig} >/dev/null 2>&1 || break
    gpg bash41-$(printf "%03d" $i).sig >/dev/null 2>&1 || exit
done
echo "*"
    # Untar bash
tar xvzf bash-4.1.tar.gz >/dev/null 2>&1
echo "*"
    # Apply patches
cd bash-4.1
cat ../bash41-??? | patch -p0 >/dev/null 2>&1
echo "*"
    # Clean up files
cd ../
find . -type f -name "bash41-*" -exec rm -f {} \;
rm -f bash-4.1.tar*
echo "**"
echo "Finished with Bash 4.1..."
echo "**"
echo "Working on Bash 4.2..."
echo "**"
if [ -d "bash-4.2" ] ; then
    rm -rf "bash-4.2"
fi
echo "*"
wget http://ftp.gnu.org/gnu/bash/bash-4.2.tar.gz{,.sig} >/dev/null 2>&1
echo "*"
    # Import public key of bash author, Chet Ramey
wget -O- http://tiswww.case.edu/php/chet/gpgkey.asc >/dev/null 2>&1 | gpg --import >/dev/null 2>&1
echo "*"
    # Verify signature
gpg bash-4.2.tar.gz.sig >/dev/null 2>&1
echo "*"
    # Download and verify patches and signatures
for i in {1..999}; do
    wget http://ftp.gnu.org/gnu/bash/bash-4.2-patches/bash42-$(printf "%03d" $i){,.sig} >/dev/null 2>&1 || break
    gpg bash42-$(printf "%03d" $i).sig >/dev/null 2>&1 || exit
done
echo "*"
    # Untar bash
tar xvzf bash-4.2.tar.gz >/dev/null 2>&1
echo "*"
    # Apply patches
cd bash-4.2
cat ../bash42-??? | patch -p0 >/dev/null 2>&1
echo "*"
    # Clean up files
cd ../
find . -type f -name "bash42-*" -exec rm -f {} \;
rm -f bash-4.2.tar*
echo "**"
echo "Finished with Bash 4.2..."
echo "**"
echo "Done!"

