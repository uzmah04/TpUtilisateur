#! /bin/bash

# Verifier si on a un dossier src ou pas dans le home et cloner le repertoire
cd
code="$(ls)"
folder="src"
if [[ "$code" == *"$folder"* ]]
then
        cd src

	Check_content="$(ls)"
	repo="TpUtilisateur"
	if [[ "$Check_content" == *"$TpUtilisateur"* ]]
	then
		echo "src/TpUtilisateur present"
	else
		git clone https://github.com/uzmah04/TpUtilisateur.git
		echo "src/TpUtilisateur successful"
	fi

else
        mkdir ~/src
	cd src
        git clone https://github.com/uzmah04/TpUtilisateur.git
        echo "src/TpUtilisateur created"
fi

cd ~/src/TpUtilisateur
sudo cp ~/src/TpUtilisateur/user.service /etc/systemd/system/user.service

sudo sudo systemctl start user.service

sudo sudo systemctl enable user.service

echo "Installation Completed"

