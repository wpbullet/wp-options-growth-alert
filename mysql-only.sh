#!/usr/bin/env bash
# Author: Mike https://wp-bullet.com

# Number of options to warn if exceed
OPTIONSTHRESHOLD=2000

# path to wp-config.php
WPCONFIGPATH=/var/www/wp-bullet.com/wp-config.php

# extracts the db information
WORDPRESSDB=$(grep DB_NAME $WPCONFIGPATH | awk -F ["\'"] '{ print $4 }' 2>/dev/null)
WORDPRESSDBUSER=$(grep DB_USER $WPCONFIGPATH | awk -F ["\'"] '{ print $4 }' 2>/dev/null)
WORDPRESSDBPASS=$(grep DB_PASSWORD $WPCONFIGPATH | awk -F ["\'"] '{ print $4 }' 2>/dev/null)
DBPREFIX=$(grep 'table_prefix' $WPCONFIGPATH | awk -F "[\']" '{print $2}' 2>/dev/null)

# get the count of wp_option rows
OPTIONSCOUNT=$(mysql -u ${WORDPRESSDBUSER} -p --password="${WORDPRESSDBPASS}" --raw --silent --skip-column-names --execute "USE ${WORDPRESSDB}; SELECT COUNT(option_name) FROM ${DBPREFIX}options;")

# check number of options found to the threshold and do something
if [[ "$OPTIONSCOUNT" -gt "$OPTIONSTHRESHOLD" ]]; then
    echo "greater than"
else
    echo "not greater"
fi
