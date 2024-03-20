#!/usr/bin/bash

default_args=("xls" "xlsx")
if [[ $# -eq 1 ]]; then
	echo usage - ./convert2csv.sh [tag] [tag]
	exit
fi
	
if [[ $# -gt 1 ]]; then
	default_args=()
	default_args=("$@")
fi

# echo ${#default_args[@]}

i=1
while [ $i -le ${#default_args[@]} ]
do
	flags[i-1]="-name *.${default_args[i-1]}"
	if (( i % 2 == 1 )); then
		flags[i-1]+=" -o"
	fi
	((i++))
done

echo Conversion In process
echo ---------------------
for file in $(find . -type f ${flags[@]})
do
  filename=$(echo "$file" | awk -F. '{print $2}')
  echo -e $file "->" .${filename}.csv
# sconvert "$file" ".${filename}.csv" --export-type=Gnumeric_stf:stf_csv > dev/null
done
