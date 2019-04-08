
# WUNDER IT ### 2019 ########################################################## REZGUI # LEBRETON #
#                               SCRIPT: SCRIPT_INSTALLATION_WORDPRESS.SH                          #
###################################################################################################



########################################################################
# ADRESSE IP DE LA MACHINE LOCALE (WORDPRESS) A RENSEIGNER ICI: ########
########################################################################
IPWordpress=
# exemple: IPWordpress=192.168.0.1

########################################################################
# ADRESSE IP DE LA MACHINE DISTANTE (BASE DE DONEES) A RENSEIGNER ICI: #
########################################################################
IPBaseDeDonnees=
# exemple: IPBaseDeDonnees=192.168.0.2 


 #! /bin/bash


# check du statut ssh si non activé, on l'active
systemctl status sshd.service 1>/dev/null
result=$?
if [ $result = 0 ]
  then 
    echo "ssh actif"
    # connexion
    ssh root@"$IPBaseDeDonnees" "$(<./script_mysql_install.sh)"
else
    echo "activation su service ssh"
    # activation du ssh
    service sshd start ;
    # connexion
    ssh root@"$IPBaseDeDonnees" "$(<./script_mysql_install.sh)"
fi

# appel du script wordpress
 ./script_wordpress.sh

####################################################################################################
