#!/bin/bash

for i in $(cat websites.txt)
do
	echo $i
	mkdir ~/Desktop/dissertation/media_and_murder/data/articles/$i/

    n=1
	for j in $(cat $i".txt")
	do
		curl $j > ~/Desktop/dissertation/media_and_murder/data/articles/$i/$i"_"$n".html"
		((n++))
	done
done
