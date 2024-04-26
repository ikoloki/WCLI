#!/usr/bin/awk -f

BEGIN {
	print "State,All Race and origins"
	FS="&#160;<br/>"
}

/<br\/>/ {
	if ($1 ~ /^[A-Z].*[a-z]$/) {
	 	state_name = $1
	}
	else if ($1 ~ /^[0-9]/) {
        state[state_name] = state[state_name] $1 ","
	}
}

END {
	for (line in state) {
		split(state[line],parts,",")
		print line","parts[1]
	}
}