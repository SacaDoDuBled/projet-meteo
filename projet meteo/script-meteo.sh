#!/bin/bash

e=0
b=0
c=0
i=0
#vérification que l'utilisateur ne tappe pas de mauvais arguments ou plusieurs fois le même nottament pour la localisation et le trie
for a in "$@"
do	
	if [ $a != "-t1" ] && [ $a != "-t2" ] && [ $a != "-t3" ] && [ $a != "-p1" ] && [ $a != "-p2" ] && [ $a != "-p3" ] && [ $a != "-w" ] && [ $a != "-m" ] && [ $a != "-h" ] && [ $a != "-F" ]&& [ $a != "-G" ] && [ $a != "-S" ] && [ $a != "-A" ] && [ $a != "-O" ] && [ $a != "-Q" ] && [ $a != "--help" ] && [ $a != "--avl" ] && [ $a != "--abr" ] && [ $a != "--tab" ] && [ $a != "-d" ] && [ $a != "-f" ]
	then
		e=$((e+1))
	elif [ $a == "-F" ] || [ $a == "-G" ] || [ $a == "-S" ] || [ $a == "-A" ] || [ $a == "-O" ] || [ $a == "-Q" ] 
	then
		b=$((b+1))
	elif [ $a == "--abr" ] || [ $a == "--avl" ] || [ $a == "--tab" ]
	then
		c=$((c+1))
	fi
	if [ $a == "-f" ]
	then
		i=$((i+1))
	fi
done


# vérification que la fonction "-f" est bien tapper en tant qu'argument
# vérification qu'un dossier est bien tapper après la fonction "-f"
# vérification que le dossier existe
# vérification que la fonction "-f" est tapper qu'une seule fois
if [ $i == 1 ]
then
	args=("$@")
	for i in "${args[@]}"; do
		if [ "$i" == "-f" ]; then
			next_arg="${args[$index+1]}"
			break
		fi
		index=$((index + 1))
	done
	if [ -z $next_arg ]
	then
		echo "Veuillez renseigner un dossier après la commande -f"
		exit
	else
		if [ -e $next_arg ]
		then
			cp $next_arg data.csv
			cp data.csv data2.csv
		else
			echo "Le dossier n'existe pas"
			exit
		fi
	fi	
elif (( $i >= 2 ))
then
	echo "veuillez utiliser la commande -f une seul fois"
	exit
elif [ $i == 0 ]
then
	echo "veuillez renseignez un nom de fichier avec la commande -f"
	exit
fi


if [ $e -ge 2 ]
then
	echo " Erreur: vos arguments ne sont pas valables "
	exit
fi

if [ $b -ge 2 ]
then
	echo " Erreur: Veuillez renseignez une seule géolocalisation "
	exit
fi

if [ $c -ge 2 ]
then
	echo " Erreur: Veuillez renseignez un un seul type de trie "
	exit
fi	

# boucle for pour chaque argument tapper de type localisation
# condition de type "case" pour les séparer
# le fichier d'entrée d'origine est alors coupé et réduit
for a in "$@"
do	
	case $a in 
		-F)
		cut -d ';' -f 1-15 data.csv | sort > alltmp.txt
		head -n 1546297 alltmp.txt > data.csv
		;;
		-Q) #ID =~ 61960
		cut -d ';' -f 1-15 data.csv | sort > alltmp.txt
		sed '1,1546297d' alltmp.txt > all2tmp.txt
		head -n 240951 all2tmp.txt > data.csv
		;;
		-O) #ID =~ 67005
		cut -d ';' -f 1-15 data.csv | sort > alltmp.txt
		sed '1,1787248d' alltmp.txt > all2tmp.txt
		head -n 25412 all2tmp.txt > data.csv
		;;
		-S) #ID =~ 71805
		cut -d ';' -f 1-15 data.csv | sort > alltmp.txt
		sed '1,1812660d' alltmp.txt > all2tmp.txt
		head -n 36827 all2tmp.txt > data.csv
		;;
		-A) #ID =~ 78925
		cut -d ';' -f 1-15 data.csv | sort > alltmp.txt
		sed '1,1849487d' alltmp.txt > all2tmp.txt
		head -n 131376 all2tmp.txt > data.csv
		;;
		-G) #ID =~ 81405
		cut -d ';' -f 1-15 data.csv | sort > alltmp.txt
		sed '1,1980863 d' alltmp.txt > all2tmp.txt
		head -n 134772 all2tmp.txt > data.csv
		;;
	esac
done

# boucle for si l'utilisateur a tapper l'option "-d"
# vérification que la date est correcte à l'aide de if inclus dans des if
for a in "$@"
do
	if [ $a == "-d" ]
	then 
		read -p "Veuillez renseigner le jour qui marque le début de l'intervalle temporel:" jourMin
		read -p "Veuillez renseigner le mois qui marque le début de l'intervalle temporel:" moisMin
		read -p "Veuillez renseigner l'année qui marque le début de l'intervalle temporel:" anMin
		read -p "Veuillez renseigner le jour qui marque la fin de l'intervalle temporel:" jourMax
		read -p "Veuillez renseigner le mois qui marque la fin de l'intervalle temporel:" moisMax
		read -p "Veuillez renseigner l'année qui marque la fin de l'intervalle temporel:" anMax
		if [ -z "$jourMin" ] && [ -z "$moisMin" ] && [ -z "$anMin" ] && [ -z "$jourMax" ] && [ -z "$moisMax" ] && [ -z "$anMax" ]
		then
			echo "Veuillez renseigner une date ou ne pas activer l'option "-d" "
			exit
		elif [ $moisMin -le 0 ] || [ $moisMin -ge 13 ] || [ $moisMax -le 0 ] || [ $moisMax -ge 13 ]
		then
			echo "Le mois de la date n'est pas correct, veuiller relancer le programme"
			exit	
		elif [ $moisMin -eq 02 ]
		then 
			if [ $jourMin -le 0 ] || [ $jourMin -ge 29 ] || [ $anMin -le 2009 ] || [ $anMin -ge 2019 ]
			then 
				echo "La date du début d'intervalle n'est pas correcte, veuiller relancer le programme"
				exit
			fi
		elif [ $moisMax -eq 02 ]
		then
			if [ $jourMax -le 0 ] || [ $jourMax -ge 29 ] || [ $anMax -le 2009 ] || [ $anMax -ge 2019 ]
			then 
				echo "La date de fin d'intervalle n'est pas correcte, veuiller relancer le programme"
				exit
			fi
		elif [ $moisMin -eq 01 ] || [ $moisMin -eq 03 ] || [ $moisMin -eq 05 ] || [ $moisMin -eq 07 ] || [ $moisMin -eq 08 ] || [ $moisMin -eq 10 ] || [ $moisMin -eq 12 ]
		then 
			if [ $jourMin -le 0 ] || [ $jourMin -ge 32 ] || [ $anMin -le 2009 ] || [ $anMin -ge 2019 ]
			then 
				echo "La date du début d'intervalle n'est pas correcte, veuiller relancer le programme"
				exit
			fi
		elif [ $moisMax -eq 01 ] || [ $moisMax -eq 03 ] || [ $moisMax -eq 05 ] || [ $moisMax -eq 07 ] || [ $moisMax -eq 08 ] || [ $moisMax -eq 10 ] || [ $moisMax -eq 12 ]
		then 
			if [ $jourMax -le 0 ] || [ $jourMax -ge 32 ] || [ $anMax -le 2009 ] || [ $anMax -ge 2019 ]
			then 
				echo "La date de fin d'intervalle n'est pas correcte, veuiller relancer le programme"
				exit
			fi
		elif [ $moisMin -eq 04 ] || [ $moisMin -eq 06 ] || [ $moisMin -eq 09 ] || [ $moisMin -eq 11 ]
		then 
			if [ $jourMin -le 0 ] || [ $jourMin -ge 31 ] || [ $anMin -le 2009 ] || [ $anMin -ge 2019 ]
			then 
				echo "La date du début d'intervalle n'est pas correcte, veuiller relancer le programme"
				exit
			fi
		elif [ $moisMax -eq 04 ] || [ $moisMax -eq 06 ] || [ $moisMax -eq 09 ] || [ $moisMax -eq 11 ]
		then 
			if [ $jourMax -le 0 ] || [ $jourMax -ge 31 ] || [ $anMax -le 2009 ] || [ $anMax -ge 2019 ]
			then 
				echo "La date de fin d'intervalle n'est pas correcte, veuiller relancer le programme"
				exit
			fi
		fi
		if [ $anMin -gt $anMax ]
		then 
			echo "Date pas valide"
			exit
		elif [ $anMin -eq $anMax ]
		then
			if [ $moisMin -gt $moisMax ]
			then
				echo "Date pas valide"
				exit
			elif [ $moisMin -eq $moisMax ]
			then
				if [ $jourMin -gt $jourMax ]
				then
					echo "Date pas valide"
					exit
				fi
			fi
		fi
		# le fichier d'entrée d'origine est alors coupé et réduit
		if [ $anMin -eq $anMax ] && [ $moisMin -eq $moisMax ] && [ $jourMin -eq $jourMax ]
		then
			date=$anMax-$moisMax-$jourMax
			grep -e "$date" data.csv > tmp.csv
			cp tmp.csv data.csv
		else
			cut -d';' -f 2 data.csv | paste - data.csv | sort -n > databis.txt
			grep -n "$anMin-$moisMin-$jourMin" databis.txt | cut -d':' -f 1 > ligne_date-min.txt
			ligne_min=$(head -n 1 ligne_date-min.txt)
			grep -n "$anMax-$moisMax-$jourMax" databis.txt | cut -d':' -f 1 |sort -nr > ligne_date-max.txt
			ligne_max=$(head -n 1 ligne_date-max.txt)
			sed -n "${ligne_min},${ligne_max}p" databis.txt > tmpdiffdate.txt
			cut -f4- -d':' tmpdiffdate.txt | cut -f3- -d'0' > data.csv
		fi
	fi
done
	
#création du fichier "stationTrieesFin.txt" qui liste de facon croissante les stations sans les répéter
cut -d ';' -f 1 data.csv | sort > stationTriees.txt
sort -u stationTriees.txt > stationTriees2.txt
sed '$d' stationTriees2.txt > stationTrieesFin.txt	
rm stationTriees2.txt	

# boucle for pour chaque argument tapper
# condition de type "case" pour séparer chaque cas d'argument
for a in "$@"
do	
	case $a in
		-t1) # vérification que les fichiers de sortie n'existe pas déjà
		if [ -e tempMinFin.txt ]
		then
			rm tempMinFin.txt
		fi

		if [ -e tempMoyFin.txt ]
		then
			rm tempMoyFin.txt
		fi

		if [ -e tempMaxFin.txt ]
		then
			rm tempMaxFin.txt
		fi
		
		if [ -e tempMin.txt ]
		then
			rm tempMin.txt
		fi

		if [ -e tempMoy.txt ]
		then
			rm tempMoy.txt
		fi

		if [ -e tempMax.txt ]
		then
			rm tempMax.txt
		fi

		cut -d ';' -f 1,11 data.csv | sort > tmptempTriees.txt
		station=$(head -n 1 stationTriees.txt)
		
		# boucle tant que pour calculer le min, le max et la moyenne des températures pour chaque stations
		while [ -n "$station" ]
		do
			station=$(head -n 1 stationTriees.txt)
			grep -e "$station" tmptempTriees.txt | cut -d ';' -f 2 > tmp2tempTriees.txt
			awk '{ print $1 }' tmp2tempTriees.txt | sort -n | sed -n '$p' >> tempMax.txt
			awk '{ sum += $1; count++ } END { print sum/count >> "tempMoy.txt" }' tmp2tempTriees.txt
			awk '{ print $1 }' tmp2tempTriees.txt | sort -n -r | sed -n '$p' >> tempMin.txt
			sed -i "/${station}/d" stationTriees.txt
		done
		
		sed -i '$d' tempMin.txt
		sed -i '$d' tempMax.txt
		sed -i '$d' tempMoy.txt
		sed -i '$d' tempMin.txt
		sed -i '$d' tempMax.txt
		sed -i '$d' tempMoy.txt
		
		# fusion des 4 fichiers: les stations et les températures min, max et moyenne pour former un unique fichier de sortie
		paste -d";" stationTrieesFin.txt tempMin.txt tempMax.txt tempMoy.txt > tempFin.txt
		
		rm tmp2tempTriees.txt
		rm tmptempTriees.txt
		rm tempMax.txt
		rm tempMin.txt
		rm tempMoy.txt
		
		# éxecution du fichier qui script le graphique des températures moy, min et max selon les stations
		./GrapheT1.sh
		;;
		-p1)# vérification que les fichiers de sortie n'existe pas déjà
		if [ -e PressMinFin.txt ]
		then
			rm PressMinFin.txt
		fi

		if [ -e PressMoyFin.txt ]
		then
			rm PressMoyFin.txt
		fi

		if [ -e PressMaxFin.txt ]
		then
			rm PressMaxFin.txt
		fi

		if [ -e PressMin.txt ]
		then
			rm PressMin.txt
		fi

		if [ -e PressMoy.txt ]
		then
			rm PressMoy.txt
		fi

		if [ -e PressMax.txt ]
		then
			rm PressMax.txt
		fi
		
		cut -d ';' -f 1,7 data.csv | sort > tmpPressTriees.txt
		station=$(head -n 1 stationTriees.txt)
		
		# boucle tant que pour calculer le min, le max et la moyenne des pressions pour chaque stations
		# la boucle se termine quand il n'y a plus de stations dans le fichiers "stationTriees.txt"
		while [ -n "$station" ]
		do
			station=$(head -n 1 stationTriees.txt)
			grep -e "$station" tmpPressTriees.txt | cut -d ';' -f 2 > tmp2PressTriees.txt
			awk '$1 != "" { print $1 }' tmp2PressTriees.txt | sort -n | head -n 1 >> PressMin.txt
			awk '{ print $1 }' tmp2PressTriees.txt | sort -n | sed -n '$p' >> PressMax.txt
			awk '{ sum += $1; count++ } END { print sum/count >> "PressMoy.txt" }' tmp2PressTriees.txt
			sed -i "/${station}/d" stationTriees.txt
		done
		
		sed -i '$d' PressMin.txt
		sed -i '$d' PressMax.txt
		sed -i '$d' PressMoy.txt
		sed -i '$d' PressMin.txt
		sed -i '$d' PressMax.txt
		sed -i '$d' PressMoy.txt
		
		# fusion des 4 fichiers: les stations et les pressions min, max et moyennes pour former un unique fichier de sortie
		paste -d";" stationTrieesFin.txt PressMin.txt PressMax.txt PressMoy.txt > PressFin.txt
		
		rm tmp2PressTriees.txt
		rm tmpPressTriees.txt
		rm PressMax.txt
		rm PressMin.txt
		rm PressMoy.txt
		
		# éxecution du fichier qui script le graphique des pressions moy, min et max selon les stations
		./GrapheP1.sh
		;;
		-t2) # les options t2 et p2 sont infiniment longue a traité car il ya beaucoup trop de donnée
			# il est donc préférable de mettre l'option "-d" afin de rétrécir le fichier data.csv
		if [ -e tempMoyFin-date.txt ]
		then
			rm tempMoyFin-date.txt
		fi

		cut -d ';' -f 2 data.csv | sort > dateTriees.txt
		sort -u dateTriees.txt > dateTriees2.txt
		cut -d ';' -f 2,11 data.csv | sort > tmptempTriees.txt
		date=$(head -n 1 dateTriees.txt)

		# boucle tant que pour calculer la moyenne des température par date pour chaque stations
		# la boucle se termine quand il n'y a plus de date dans le fichiers "dateTriees.txt"
		while [ -n "$date" ]
		do
			date=$(head -n 1 dateTriees.txt)
			grep -e "$date" tmptempTriees.txt | cut -d ';' -f 2 | awk '{ sum += $1; count++ } END { print sum/count >> "tempMoyFin-date.txt" }'
			sed -i "/${date}/d" dateTriees.txt
		done
		
		# fusion des deux fichier: les stations et les température moyennes par date pour former un unique fichier de sortie
		paste -d";" dateTriees2.txt tempMoy-date.txt > tempMoyFin-date.txt
		rm dateTriees.txt
		rm tmptempTriees.txt
		rm dateTriees2.txt
		rm tempMoy-date.txt
		
		# éxecution du fichier qui script le graphique de la température par date/heure
		./GrapheT2.sh
		;;
		-p2)
		if [ -e PressMoyFin-date.txt ]
		then
			rm PressMoyFin-date.txt
		fi

		cut -d ';' -f 2 data.csv | sort > dateTriees.txt
		sort -u dateTriees.txt > dateTriees2.txt
		cut -d ';' -f 2,7 data.csv | sort > tmpPressTriees.txt
		date=$(head -n 1 dateTriees.txt)

		# boucle tant que pour calculer le min, le max et la moyenne des pressions pour chaque stations
		# la boucle se termine quand il n'y a plus de date dans le fichiers "dateTriees.txt"
		while [ -n "$date" ]
		do
			date=$(head -n 1 dateTriees.txt)
			grep -e "$date" tmpPressTriees.txt | cut -d ';' -f 2 | awk '{ sum += $1; count++ } END { print sum/count >> "PressMoy-date.txt" }'
			sed -i "/${date}/d" dateTriees.txt
		done
		
		# fusion des deux fichier: les stations et les pressions moyennes par date pour former un unique fichier de sortie
		paste -d";" dateTriees2.txt PressMoy-date.txt > PressMoyFin-date.txt
		rm dateTriees.txt
		rm tmpPressTriees.txt
		rm dateTriees2.txt
		rm PressMoy-date.txt
		
		# éxecution du fichier qui script le graphique des pressions par date/heure
		./GrapheP2.sh
		;;
		-t3)
		if [ -e tempFin-date-station.txt ]
		then
			rm tempFin-date-station.txt
		fi

		cut -d ';' -f 1,2,11 data.csv | sort > tempFin-date-station.txt
		
		# éxecution du fichier qui script le graphique de la température par date par station
		./GrapheT3.sh
		;;
		-p3)
		if [ -e PressFin-date-station.txt ]
		then
			rm PressFin-date-station.txt
		fi

		cut -d ';' -f 1,2,11 data.csv | sort > PressFin-date-station.txt
		
		# éxecution du fichier qui script le graphique de la pression par date par station
		./GrapheP3.sh
		;;
		-w)
		if [ -e dir-ventFin.txt ]
		then
			rm dir-ventFin.txt
		fi
		
		if [ -e vit-ventFin.txt ]
		then
			rm vit-ventFin.txt
		fi

		cut -d ';' -f 1 data.csv | sort > stationTriees.txt
		cut -d ';' -f 1,4 data.csv | sort > dirventTriees.txt
		cut -d ';' -f 1,5 data.csv | sort > vitventTriees.txt
		station=$(head -n 1 stationTriees.txt)
		
		# boucle tant que pour calculer la direction et le vent moyen pour chaque stations
		# la boucle se termine quand il n'y a plus de stations dans le fichiers "stationTriees.txt"		
		while [[ "$station" !=  *ID* ]] && [ -n "$station" ]
		do
			station=$(head -n 1 stationTriees.txt)
			grep -e "$station" dirventTriees.txt | cut -d ';' -f 2 | awk '{ sum += $1; count++ } END { print sum/count >> "dir-ventFin.txt" }'
			grep -e "$station" vitventTriees.txt | cut -d ';' -f 2 | awk '{ sum += $1; count++ } END { print sum/count >> "vit-ventFin.txt" }'
			sed -i "/${station}/d" stationTriees.txt
		done
		
		sed -i '$d' dir-ventFin.txt
		sed -i '$d' vit-ventFin.txt
		
		# fusion des 3 fichier: les stations et les vitesses et directions moyens pour former un unique fichier de sortie
		paste -d";" stationTrieesFin.txt dir-ventFin.txt vit-ventFin.txt > VentFin.txt
		
		rm dirventTriees.txt
		rm vitventTriees.txt
		rm dir-ventFin.txt
		rm vit-ventFin.txt
		
		# L'argument w n'émet pas de graphes car nous n'avons pas réussi à en générer un de type vecteurs
		;;
		-h)
		if [ -e altFin.txt ]
		then
			rm altFin.txt
		fi
		
		cut -d ';' -f 1,14 data.csv | sort > altTriees.txt
		sort altTriees.txt | uniq > alt2Triees.txt
		# trie selon la deuxième colonne donc utilisation de "-K2"
		head -n 62 alt2Triees.txt | sort -t";" -k2 -nr > altFin.txt
		rm altTriees.txt
		rm alt2Triees.txt
		
		# éxecution du fichier qui script le graphique de l'altitude
		./GrapheAlt.sh
		;;
		-m)
		if [ -e HumMaxFinMaxFin.txt ]
		then
			rm HumMaxFin.txt
		fi

		cut -d ';' -f 1,6 data.csv | sort > tmpPressTriees.txt
		sort -u tmpPressTriees.txt > tmp2PressTriees.txt
		# trie selon la deuxième colonne donc utilisation de "-K2"
		sort -n tmp2PressTriees.txt | sort -t";" -k2 -nr > tmp3PressTriees.txt
		# coupe des 62 premières lignes car il y a 62 stations différentes
		head -n 62 tmp3PressTriees.txt > HumMaxFin.txt
		rm tmpPressTriees.txt
		rm tmp2PressTriees.txt
		rm tmp3PressTriees.txt
		
		# éxecution du fichier qui script le graphique de l'humidité
		./GrapheHum.sh
		;;
		--tab) #éxecution des programme c
		./triTAB.c
		;;
		--abr)
		./triABR.c
		;;
		--avl)
		./triAVL.c
		;;
		--help)
		echo -e "-t<mode>  : (t)emperatures.  -p<mode> : (p)ressions atmosphériques.◦Pour ces 2 options, il faut indiquer la valeur du<mode> :◦1  :   produit   en   sortie   les   températures   (ou   pressions)minimales, maximales et moyennes par station dans l’ordrecroissant du numéro de station.◦2  :   produit   en   sortie   les   températures   (ou   pressions)moyennes par date/heure, triées dans l’ordre chronologique.La moyenne se fait sur toutes les stations.◦3  :   produit   en   sortie   les   températures   (ou   pressions)   pardate/heure par station. Elles seront triées d’abord par ordrechronologique, puis par ordre croissant de l’identifiant de lastation\n"
		echo -e "L’option -w: vent ( (w)ind )\n"
		echo -e "L’option -h : altitude ( (h)eight)\n"
		echo -e "L’option -m : humidité ( (m)oisture )\n"
		echo -e "▪option -F : (F)rance: France métropolitaine + Corse.▪option -G : (G)uyane française.▪option -S : (S)aint-Pierre et Miquelon: ile située à l’Est du Canada▪option -A : (A)ntilles.▪option -O : (O)céan indien.▪option -Q : antarcti(Q)ue\n"
		echo -e "-d<min> <max> : (d)ates"
		echo -e "--tab: tri effectué à l’aide d’une structure linéaire (au choix un tableauou une liste chaînée)\n"
		echo -e "--abr: tri effectué l’aide d’une structure de type ABR\n"
		echo -e "--avl: tri effectué à l’aide d’une structure de type AVL\n"
		echo -e "-f<nom_fichier> : (f)ichier d’entrée.Cette option est obligatoire\n"
		;;
	esac
done

echo "0"
