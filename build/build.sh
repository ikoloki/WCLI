#!/bin/bash

if ! test -f ./CSV/tmp.org; then
	awk -F'|' '{print $2","$4}' tmp.org > CSV/resource_link_table.csv
fi

awk  -F, ''  resource_link_table.csv