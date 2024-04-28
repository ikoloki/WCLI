#!/usr/bin/awk -f

# The following only measures Female Life spands

BEGIN {
	FS=","
 	print "State,Average Age Death"
}

$2 == "Female" {
	print $1","$3
}