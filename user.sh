#!/bin/bash

cd /home/uzmah/src/TpUtilisateur
while [ true ]
do
	cd /home/uzmah/src/TpUtilisateur
	code="$(ls)"
	fichier="employees.csv"

	if [[ "$code" == "*$fichier*" ]]
	then
		cd /home/uzmah/src/TpUtilisateur
		# Pour convertir le fichier excel(.xls) en fichier (.csv)
		xls2csv Employees.xls > employees.csv
	else
                touch /home/uzmah/src/TpUtilisateur/employees.csv
		cd /home/uzmah/src/TpUtilisateur
		xls2csv Employees.xls > employees.csv
	fi

	# Le repertoire du fichier employees.csv stocker dans la variable liste
	liste="/home/uzmah/src/TpUtilisateur/employees.csv"

	# Stocker les users obtenu par le code dans un array
	array=($(awk -F: '{ print $1 }' /etc/passwd))

	i=0

	# While loop pour lire chaque ligne du fichier employees.csv
	while IFS= read -r line
	do
		i=0

		# Verifie si chaque personne dans le fichier employees.csv a un user

		# Si le user existe deja, le if va donner la valeur 1 a i
		# Et le while loop va continuer a executer
		for person in ${array[*]}
		do
			if [[ "$line" = "\"$line\"" ]]
			then
				i=$((i+1))
			fi
		done

		# Mais si le user n'existe pas, le if ne va pas etre executer
		# Ainsi la valeur de i reste 0
		# Le if a l'exterieur du for loop va etre executer
		if [[ "$i" = 0 ]]
		then
			# Le nom du user qu'on va creer est stocker dans la variable nom
			# Le code entre parenthese () donne le nom dans le fichier employees.csv sans les guillemets
			# sed ...//g' elimine les guillemets
			nom="$(echo $line | sed 's/\"//g')"

			# Creer le user
			useradd $nom

			# Donne home directory au user
			mkhomedir_helper $nom
		fi

	done < $liste
done
