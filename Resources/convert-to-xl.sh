#!/usr/bin/bash

for file in $(find . -type f ! -name '*.pdf' ! -name '*.html' ! -name '*.sh'); do
    extension=$(echo "$file" | awk -F. '{print $NF}')
    filename=$(echo "$file" | awk -F. '{print $2}')
	
    if [[ $extension == "csv" ]]; then
        continue
    fi
    
    ssconvert "$file" "./${filename}.csv" --export-type=Gnumeric_stf:stf_csv
done