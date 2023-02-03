#!/usr/bin/gnuplot -persist

reset
set terminal png size 1100, 600
set grid layerdefault lt 0 linecolor 0 linewidth 0.5, lt 0 linecolor 0 linewidth 0.5
set output 'Pression_moy_date.png'
set title "Pression_moy_date"
set title font ",17"
set xlabel "x"
set xlabel font "0,2"
set xtic(1) rotate 90
set ylabel "y"
set ylabel font "0,2"
set datafile separator ';'
plot 'PressMoyFin-date.txt' using 1:2:xtic(1) with linespoint linewidth 3 linecolor 0 title "Press"
		
