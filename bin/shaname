#!/bin/bash
for file
do
	sha1=$(sha1sum $file | cut -d' ' -f1)
	ext=$(basename $file | cut -d'.' -f2)
	shaname=$sha1.$ext
	mv -n $file $shaname
done
