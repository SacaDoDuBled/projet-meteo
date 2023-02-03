#!/usr/bin/gnuplot -persist

reset
set terminal png size 1600, 1000
set grid layerdefault lt 0 linecolor 0 linewidth 0.5, lt 0 linecolor 0 linewidth 0.5
set output 'Press_min_moy_max_station.png'
set title "Press_min_moy_max_station"
set title font ",17"
set xlabel "x"
set xlabel font "0,2"
set xtic(1) rotate 90
set ylabel "y"
set ylabel font "0,2"
set datafile separator ';'
plot 'PressFin.txt' using 1:2:3:4:xtic(1) with linespoint linewidth 3 linecolor 0 title "Press"
		
