#!/bin/bash

#outer = 1
for i in $(cat websites.txt)
do
	echo $i
	mkdir ~/Desktop/dissertation/media_and_murder/data/articles/$i/

    #counter = 1
    n=1
	for j in $(cat $i".txt")
	do
		curl $j > ~/Desktop/dissertation/media_and_murder/data/articles/$i/$i"_"$n".html"
		#curl $j > ~/Desktop/dissertation/media_and_murder/data/articles/elcolombiano/$i_$j
		#inner = $((inner+1))
		#counter = $((counter+1))
		((n++))
	done
done
