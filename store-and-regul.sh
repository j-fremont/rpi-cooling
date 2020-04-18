#! /bin/bash
NB_VALUES=180 # One measurement every 10s for 30 minutes
ON_THRESHOLD=50.0
OFF_THRESHOLD=45.0
fan=0 # The fan is initially off
gpio mode 0 out
while true; do
	temp=$(vcgencmd measure_temp | sed -En "s/temp=(.*)'C/\1/p")
	echo $temp >> ./store.dat
	tail -n $NB_VALUES ./store.dat > ./last_store.dat
	mv ./last_store.dat ./store.dat
	# Start the fan if the temperature has reached the limit and the fan isn't already running
	if (( $(echo "$temp>$ON_THRESHOLD" | bc -l) & $fan==0 )); then
		gpio write 0 1
		fan=1
	# Stop the fan if the temperature has dropped below the limit and the fan is running
	elif (( $(echo "$temp<$OFF_THRESHOLD" | bc -l) & $fan==1 )); then
		gpio write 0 0
		fan=0
	fi
	sleep 10 # One measurement every 10s
done
