#!/bin/bash

awk -F'|' '{print $2","$4}' ../readme.org | tail -n +4 > ../build/resource_link_table.csv
[ -d "../resources/" ] && rm -rf "../resources/"

codes=()
links=()

while IFS=',' read -r code link; do
  code=$(echo "$code" | tr -d ' ')
  link=$(echo "$link" | tr -d ' ')
  codes+=("$code")
  links+=("$link")
done  < ../build/resource_link_table.csv

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

echo "Making Clean directory"
mkdir '../resources/Clean'

echo "Processing Happiness"
./scripts/./happy.awk "../resources/Happiness/Happiness.???" > ../resources/Clean/clean-Happiness.csv

echo "Processing Aborton"
mv ../resources/Abortion/Abortion.xlsx ../resources/Clean/clean-Abortion.xlsx

echo "Processing Life Expectancy"
./scripts/./life_expect.awk ../resources/LifeExpectancy/LifeExpectancy.??? > ../resources/Clean/clean-LifeExpectancy.csv

echo "Processing Pregnancy"
pdftohtml ../resources/Pregnancy/Pregnancy.pdf -stdout | ./scripts/./Pregnacy.awk > ../resources/Clean/clean-Pregnancy.csv

scripts/./convert2csv.sh

echo "Processing Abortion Data"
scripts/./Abortion.R

../src//./clean_data.R