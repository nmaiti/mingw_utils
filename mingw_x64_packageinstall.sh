#!/bin/bash

# Install mingw64 packages from msys2
# How to use
# install zstd from https://github.com/facebook/zstd/releases in bin folder
# 

cd /

echo $1
# echo $2

URL=http://repo.msys2.org/msys/x86_64

# TODO option to select particular package and version can be taken as input by splitting folloing line
#FILE=`wget -O - -o /dev/null $URL | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep -E ^$1-[0-9] | egrep -v '.sig$' | sort | tail -1f`
FILE=`curl -fsSL $URL | sed -n 's/.*href="\([^"]*\).*/\1/p' | grep -E ^$1-[0-9] | egrep -v '.sig$' | sort | tail -1f`


echo $FILE
if [[ -z $FILE ]] ; then
	echo "$1 package not found"
	exit 0
fi
# wget -qO- $URL/$FILE | tar -I zstd -xvf - -C /
curl -fsSL $URL/$FILE -o ./$FILE
if [[ -e ./$FILE]] && [[ $FILE == *.zst ]] # * is used for pattern matching
then
#  wget -qO- $URL/$FILE | tar -I zstd -xvf - -C ./
  tar -I zstd -xvf $FILE -C /
  rm -rf $FILE
elif [[ -e ./$FILE]] && [[ $FILE == *.xz ]]
then
  tar  -xJvf $FILE -C /
  rm -rf $FILE
#  wget -qO- $URL/$FILE | tar xJvf - -C /
else
  echo "$FILE is not extracted"
fi