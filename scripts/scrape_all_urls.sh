#!/bin/bash

for i in $(cat websites.txt)
do
	mkdir ~/Desktop/dissertation/media_and_murder/data/articles/$i/
	counter = 1

	for j in $(cat $i.txt)
	do
		curl $i > ~/Desktop/dissertation/media_and_murder/data/articles/elcolombiano/$i_$counter
		counter = $((counter+1))
	done
done
