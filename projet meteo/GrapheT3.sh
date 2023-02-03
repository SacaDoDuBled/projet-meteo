#!/usr/bin/gnuplot -persist

reset
set terminal png size 1100, 600
set grid layerdefault lt 0 linecolor 0 linewidth 0.5, lt 0 linecolor 0 linewidth 0.5
set output 'Température_date_station.png'
set title "Température_date_station"
set title font ",17"
set xlabel "x"
set xlabel font "0,2"
set xtic(1) rotate 90
set ylabel "y"
set ylabel font "0,2"
set datafile separator ';'
plot 'tempFin-date-station.txt' using 1:2:3:xtic(1) with linespoint linewidth 3 linecolor 0 title "Temp"
		
