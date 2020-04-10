#! /bin/bash
NB_VALUES=180 # One measurement every 10s for 30 minutes
while true; do 
	temp=$(vcgencmd measure_temp | sed -En "s/temp=(.*)'C/\1/p")
	echo $temp >> ./store.dat
	tail -n $NB_VALUES ./store.dat > ./last_store.dat
	mv ./last_store.dat ./store.dat
	sleep 10 # One measurement every 10s
done
