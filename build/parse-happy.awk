#!/usr/bin/awk -f

BEGIN {
    FS = "</?td>"
	print "State,Emotional & Physical Well Being,Work Enviroment,Community & Enviroment,Overall rank"
}

{
    for (i = 2; i < NF; i += 2) {
		printf("%s%s", $i, (i % 12 == 0) ? "\n" : ",")
    }
}