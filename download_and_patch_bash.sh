#!/bin/bash

echo "Working on Bash 4.1..."
echo "*"
wget http://ftp.gnu.org/gnu/bash/bash-4.1.tar.gz{,.sig}
echo "*"
    # Import public key of bash author, Chet Ramey
wget -O- http://tiswww.case.edu/php/chet/gpgkey.asc | gpg --import
echo "*"
    # Verify signature
gpg bash-4.1.tar.gz.sig
echo "*"
    # Download and verify patches and signatures
for i in {1..999}; do
    wget http://ftp.gnu.org/gnu/bash/bash-4.1-patches/bash41-$(printf "%03d" $i){,.sig} || break
    echo "*"
    gpg bash41-$(printf "%03d" $i).sig || exit
    echo "*"
done
echo "*"
    # Untar bash
tar xvzf bash-4.1.tar.gz
echo "*"
    # Apply patches
cd bash-4.1
cat ../bash41-??? | patch -p0
echo "*"
    # Clean up files
cd ../
find . -type f -name "bash41-*" -exec rm -f {} \;
rm -f bash-4.1.tar*
echo "*"
echo "Finished with Bash 4.1..."

echo "Working on Bash 4.2..."
echo "*"
wget http://ftp.gnu.org/gnu/bash/bash-4.2.tar.gz{,.sig}
echo "*"
    # Import public key of bash author, Chet Ramey
wget -O- http://tiswww.case.edu/php/chet/gpgkey.asc | gpg --import
echo "*"
    # Verify signature
gpg bash-4.2.tar.gz.sig
echo "*"
    # Download and verify patches and signatures
for i in {1..999}; do
    wget http://ftp.gnu.org/gnu/bash/bash-4.2-patches/bash42-$(printf "%03d" $i){,.sig} || break
    echo "*"
    gpg bash42-$(printf "%03d" $i).sig || exit
    echo "*"
done
echo "*"
    # Untar bash
tar xvzf bash-4.2.tar.gz
echo "*"
    # Apply patches
cd bash-4.2
cat ../bash42-??? | patch -p0
echo "*"
    # Clean up files
cd ../
find . -type f -name "bash42-*" -exec rm -f {} \;
rm -f bash-4.2.tar*
echo "*"
echo "Finished with Bash 4.2..."
echo
echo "Done!"

