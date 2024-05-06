#!/bin/bash

awk -F'|' '{print $2","$4}' ../build/tble.org | tail -n +4 > ../build/resource_link_table.csv
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

echo "Cleaning data"
../src/cleaning/clean_data.R

echo "Processing Data Further"
cut -d',' -f2- ../resources/Clean/clean-master-data.csv | awk -F, 'BEGIN{OFS=","} {$2=""; print $0}' | sed 's/,,/,/g' | awk 'NR == 1 {print $0} NR > 1 {gsub(/"\."/,"NA",$0); print $0}' | awk '!/("United States"|"District of Columbia")/' |
	Rscript -e 'data <- read.table(file("stdin"), header = TRUE, sep = ",", na.strings = "NA"); data_numeric <- data[, sapply(data, is.numeric)]; data$WQLI <- rowSums(data_numeric, na.rm = TRUE); write.csv(data, file = "../resources/Clean/tmp.csv", row.names = FALSE)'
cat ../resources/Clean/tmp.csv > ../resources/Clean/clean-master-data.csv
rm ../resources/Clean/tmp.csv

cp ../resources/Clean/clean-master-data.csv ../src/app/
echo "done"
echo "everything should be up and running"
echo "you should be able to run the rsconnect script to connect to shiny fine"