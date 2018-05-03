#!/bin/sh
# shaname.sh - rename files to their sha1sums
# 
# Copyright (c) 2018 Torro
# See the file "copying.txt" included in this
# directory for details about the copyright.

for file
do
	sha1=$(sha1sum $file | cut -d' ' -f1)
	ext=$(basename $file | cut -d'.' -f2)
	shaname=$sha1.$ext
	mv -n $file $shaname
done
