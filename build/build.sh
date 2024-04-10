#!/bin/bash

awk -F'|' '{print $2","$4}' ../readme.org | tail -n +4 > ../build/CSV/resource_link_table.csv

[ -d "../resources/" ] && rm -rf "../resources/"

codes=()
links=()

while IFS=',' read -r code link; do
  code=$(echo "$code" | tr -d ' ')
  link=$(echo "$link" | tr -d ' ')
  codes+=("$code")
  links+=("$link")
done < ../build/CSV/resource_link_table.csv

if [ ! -d "../resources/" ]; then
	echo Making resources dir
	mkdir ../resources
fi

i=0
for code in "${codes[@]}"; do
	if [ ! -d "../resources/${codes[i]}" ]; then
		if [ ! -z "${links[i]}" ]; then
			echo -e "creating ../resources/${codes[i]}"
			mkdir "../resources/${codes[i]}"
			curl -L -o "../resources/${codes[i]}/${codes[i]}" "${links[i]}" 
			ext=$(file --extension "../resources/${codes[i]}/${codes[i]}" | awk '{print $NF}')
			
			mv "../resources/${codes[i]}/${codes[i]}" "../resources/${codes[i]}/${codes[i]}.${ext}"
			echo -e Created "../resources/${codes[i]}/${codes[i]}.${ext}"
		fi
	fi
	((i++))
done

./convert2csv.sh
mkdir ../resources/Abortion/Clean
./../src/clean_abortion_data.awk ../resources/Abortion/Abortion.csv > ../resources/Abortion/Clean/SumAborition.csv

