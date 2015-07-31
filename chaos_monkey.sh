#!/bin/bash

minSleep=60
maxSleep=300
user="ssh-user"
hosts=("host1", "host2")

downCommand="service my-tested-service stop"
upCommand="service my-tested-service start"

#
# DO NOT EDIT BELOW THIS LINE
#
numHosts=${#hosts[@]}
maxRand=$((maxSleep - minSleep))

function outputPercBar {
	amount=$1
	total=$2
	barStyle=([ \# \  ])
	barLen=25
	twirlChars=("|" "/" "-" "\\")
	numTwirl=${#twirlChars[@]}

	perc=$((amount*100 / total))
	divider=$((100/barLen))
	outPerc=$((perc/divider))

	str=${barStyle[0]}
	for j in $(eval echo {1..$barLen}); do
		if [[ $j -le $outPerc ]]; then
			str=$str${barStyle[1]}
		else
			str=$str${barStyle[2]}
		fi
	done
	
	twirlStep=$((i%numTwirl))
	twirlChar=${twirlChars[$twirlStep]}

	str=$str${barStyle[3]}
	str=$str"("$perc"%)"
	if [[ $perc -ge 100 ]]; then
		tput el
		echo "$str"
	else
		tput el
		echo -ne "["$twirlChar"]$str\r"
	fi
}

function interruptHost {
	pause 
	echo "interrupting" $1
	ssh $user@$1 $downCommand
	pause 
	echo "resuming" $1
	ssh $user@$1 $upCommand
}

function pause {
	sleep=$((RANDOM % maxRand+1))
	sleep=$((sleep + minSleep))	
	i=0
	while [ $i -lt $sleep ]; do
		sleep 1
		i=$((i+1))
		outputPercBar $i $sleep
	done
}


while true; do
	#pick random host
	rand=$((RANDOM % numHosts))
	host=${hosts[$rand]}

	#interrupt the host
	interruptHost $host
done

