#!/usr/bin/awk -f

BEGIN {
    FS=","
}

NR > 1 {
	for (i = 3; i <= NF; i++) {
		if ($i == $3) {
			split($3, date_parts, "/")
			date_string = sprintf("%d %d %d 00 00 00", date_parts[1], date_parts[2], date_parts[3])
			unix_time = mktime(date_string)
		}
		if ($i == ".") {
			wholes++
		}
		
		if (NF > 3) {
			if ($i ~ "^[01]") {
				sum += $i
			}
		}
		
		split(state_array[$1], state_array_parts, ",")
		if (state_array[$1] == "") {
			state_array[$1] = sprintf("%d,%d,%d",unix_time, sum, wholes)
		}
		if (state_array_part[2] > unix_time) {
			state_array[$1] = sprintf("%d,%d,%d",unix_time, sum, wholes)
		}
		else {
			state_array[$1] = sprintf("%d,%d,%d",unix_time, sum, wholes)
		}
	}
	sum = 0
	wholes = 0
}

END {
	print "State,UnixTime,Sum,Wholes"
	for (state in state_array) {
		print state","state_array[state]
	 }
}
