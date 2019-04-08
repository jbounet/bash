#!/bin/bash

##

#creation des vhosts apache
#usage :
# ./addvhost vhost_name [use.ssl]
##

if [ $# == 0 ]
then
	echo "To few arguments to process. Operation failed"
	exit -1
fi

