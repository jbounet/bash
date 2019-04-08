#!/bin/bash

##

#creation des vhosts apache
#usage :
# ./addvhost vhost_name [use.ssl]
##

ROOT_DIR="/home/julienbounet/www/"
if [ $# == 0 ]
then
	echo "To few arguments to process. Operation failed"
	exit -1
else
	# copier le fichier template symfony vers /etc/apache2/sites-available
	#avec le nom vhost_name.conf
	cp ./template-symfony /etc/apache2/sites-available/$1.conf
	
	mkdir -p $ROOT_DIR$1 $ROOT_DIR$1/web


	sed -i 's/template/'$1'/g' /etc/apache2/sites-available/$1.conf

	#ajout fichier de conf à la liste des sites actifs
	a2ensite $1.conf 

	#mettre à jour le fichier hosts
	echo "10.31.1.203 $1.wrk www.$1.wrk" >> /etc/hosts

	#vérif execution globale
	touch $ROOT_DIR$1/web/app.php
	echo "<?php phpinfo();" >> $ROOT_DIR$1/web/app.php

	#relancer service apache
	systemctl reload apache2.service


fi

