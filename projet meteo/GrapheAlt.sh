#!/usr/bin/gnuplot -persist

reset
set terminal png size 1800, 1200
set grid layerdefault lt 0 linecolor 0 linewidth 0.5, lt 0 linecolor 0 linewidth 0.5
set output 'Altitude_moyenne_par_station.png'
set title "altitude"
set title font ",17"
set xlabel "x"
set xlabel font "0,2"
set xtic(1) rotate 90
set ylabel "y"
set ylabel font "0,2"
set datafile separator ';'
plot 'altFin.txt' using 0:2:xtic(1) with linespoint linewidth 3 linecolor 0 title "Alt"
		
