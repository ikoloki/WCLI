#!/bin/bash

awk -F'|' '{print $2","$4}' ../readme.org | tail -n +2 > CSV/resource_link_table.csv

IFS=','
codes=()
links=()

tail -n +4 CSV/resource_link_table.csv |
	while read -r code link; do
    code=$(echo "$code" | tr -d ' ')
    link=$(echo "$link" | tr -d ' ')
    codes+=("$code")
    links+=("$link")
done

gecho Making resources dir
[ -d ../resources/ ] && mkdir ../resources/

i=0
for dir in ${codes[@]}; do	
	curl -o ../resources/${codes[i]}/${codes[i]} ${links[i]}  > /dev/null 2>&1
	[ -d ../resources/ ] && echo "creating ../resources/${codes[i]}" ;  mkdir ../resources/${codes[i]}
	ext=$(file --extension ../resources/${codes[i]}/${codes[i]} | awk '{print $NF}')
	mv "../resources/${codes[i]}/${codes[i]}" "../resources/${codes[i]}/${codes[i]}.${ext}"
	echo Created "../resources/${codes[i]}/${codes[i]}.${ext}"
	((i++))
done

./convert2csv.sh