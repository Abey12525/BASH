#!/bin/bash
d=0.0
bid= ` echo $$ ` 
while [ 1 ]
do
	d=` ps -ux |tr -s ' '|cut -d " " -f2,3|sort -k 2|tail -n 2|head -n 1|cut -d " " -f2 `
	echo " cpu usage $d "
	e=` ps -ux |tr -s ' '|cut -d " " -f2,4|sort -k 2|tail -n 2|head -n 1|cut -d " " -f2 `
	echo " memory is $e "
	bid=` ps -ux |tr -s ' '|grep -w bash|cut -d " " -f2 `
	if [[ $d > 0.0 || $e > 0.0 ]]
		then
			if [[ $d > $e+50 ]]
			then
				echo " killing process with CPU usage"
				k=`ps -ux |tr -s ' '|cut -d " " -f2,3|sort -k 2|tail -n 2|head -n 1|cut -d " " -f1`	
				if [[ $bid -eq $k ]]
				then 
					echo "running terminal" 
				else 
					echo "killing process $k"
					kill $k
				fi
			else 
				echo " killing process with memory usage"
				l=` ps -ux |tr -s ' '|cut -d " " -f2,4|sort -k 2|tail -n 2|head -n 1|cut -d " " -f1 `
				if [[ $bid -eq $l ]]
				then 
					echo "running terminal" 
				else 
					echo "killing process $l"
					kill $l
				fi
			fi
		else
			echo "no process currently above threshold"
		
	fi
done
