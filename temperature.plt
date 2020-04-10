set terminal wxt size 400,200
set size 1,1
set title 'Température Raspberry Pi 4'  
#set ylabel 'Température'
set yrange [20:80]
unset xtics
set ytics font "Verdana,6"
unset key
#plot "store.dat" smooth csplines
plot "store.dat" with lines
pause 10
reread