#!/bin/sh -e
# 
# Compile all the code
#
NAME=$( cat name )

for m in `find src/${NAME} -path src/${NAME}/vendor -prune -o -name main.go -print`
do
	d=$( dirname $m )
	b=$( basename $d )
	p=$( echo $d | cut -d'/' -f2- )
	go build -o bin/${NAME}${b} ${p}
done
