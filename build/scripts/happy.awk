#!/usr/bin/awk -f

BEGIN {
    FS = "</?td>"
	print "Rank,State,Total,Emotional & Physical Well Being,Work Enviroment,Community & Enviroment"
}

{
    for (i = 2; i < NF; i += 2) {
		printf("%s%s", $i, (i % 12 == 0) ? "\n" : ",")
    }
}