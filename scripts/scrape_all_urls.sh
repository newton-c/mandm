#!/bin/sh

for i in $(cat websites.txt)
do
	echo $i
	mkdir -p /Users/cn/Desktop/Dissertation/mandm/data/articles/"$i"


    n=1
	for j in $(cat $i".txt")
	do
		curl $j > /Users/cn/Desktop/Dissertation/mandm/data/articles/$i/$i"_"$n".html"

		((n++))
	done
done