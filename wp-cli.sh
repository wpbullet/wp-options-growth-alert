#!/usr/bin/env bash
# Purpose: Get number of wp_options rows for WordPress installation using WP-CLI
# Author: Mike https://wp-bullet.com

# Number of options to warn if exceeded
OPTIONSTHRESHOLD=2000

# path to WordPress installation
WPPATH=/var/www/wp-bullet.online

# get wp_options table
WPOPTIONSTABLE=$(wp db tables --scope=blog --url=$(wp option get siteurl --path=$WPPATH --allow-root) --path=$WPPATH --allow-root | grep _options)

# get the count of wp_option rows
OPTIONSCOUNT=$(wp db query "USE ${WORDPRESSDB}; SELECT COUNT(option_name) FROM $WPOPTIONSTABLE;" --raw --silent --skip-column-names --path=$WPPATH --allow-root)

# check number of options found to the threshold and do something
if [[ "$OPTIONSCOUNT" -gt "$OPTIONSTHRESHOLD" ]]; then
    echo "greater than"
else
    echo "not greater"
fi
