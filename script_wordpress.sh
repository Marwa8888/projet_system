
# WUNDER IT ### 2019 ########################################################## REZGUI # LEBRETON #
#                                   SCRIPT: SCRIPT_WORDPRESS.SH                                   #
###################################################################################################

 #! /bin/bash


# navigation au bon endroit et installation d'apache

cd /
yum clean all
yum -y install httpd
cd /opt

# telechargement de wordpress, décompréssion, installation et modification des droits pour apache

wget https://wordpress.org/latest.tar.gz
tar -C /var/www/html/ --strip-components=1 -zxvf latest.tar.gz && rm -f latest.tar.gz
cd /var/www/html
mkdir wp-content/{uploads,cache}
chown apache:apache wp-content/{uploads,cache}
 
# configuration de WordPress

cp wp-config-sample.php wp-config.php
sed -i 's@database_name_here@wordpress@' wp-config.php
sed -i 's@username_here@wordpress@' wp-config.php
sed -i 's@password_here@password@' wp-config.php
echo '-P httpd_can_network_connect_db 1' >> wp-config.php
curl https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php 

# configuration d'apache

chown -R apache: /var/www/html
sed -i "/^<Directory \"\/var\/www\/html\">/,/^<\/Directory>/{s/AllowOverride None/AllowOverride All/g}" /etc/httpd/conf/httpd.conf
systemctl enable httpd.service
systemctl start httpd.service

# vérification de l'installation de Wordpress

result=$?
if [ $result = 0 ]
  then 
    echo "Installation terminée, vous pouvez lançer votre navigateur à l'adresse localhost pour configurer Wordpress."
else
    echo "L'installation a échouée, veuillez relançer le script svp. Si le problème persiste, veuillez contactez le support (voir documentation)"
fi

####################################################################################################