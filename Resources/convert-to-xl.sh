#!/usr/bin/bash

if [[ $# -eq 0 ]]; then
   echo 'You need to specify the input file extension'
   exit 1
fi

for file in $(find . -type f ! -name '*.pdf' ! -name '*.html' ! -name '*.sh'); do
    extension=$(echo "$file" | awk -F. '{print $NF}')
    filename=$(echo "$file" | awk -F. '{print $1}')
    
    if [[ $extension == "xls" ]]; then
        continue
    fi
    ssconvert "$file" "$filename.xls" "Gnumeric_Excel:excel_biff5"
done

