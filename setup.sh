#!/bin/bash

echo "\033[35mWelcom to the Municipio boilerplate setup.\nPlease follow the steps in this setup guide in order to set up your wp-config.\033[0m"

#
##
### DATABASE
##
#

echo "\n\033[34m\033[1mDatabase host:\033[0m "
read db_host

echo "\n\033[34m\033[1mDatabase name:\033[0m "
read db_name

echo "\n\033[34m\033[1mDatabase user:\033[0m "
read db_user

echo "\n\033[34m\033[1mDatabase password:\033[0m "
read db_password

echo "\n\033[34m\033[1mDatabase table prefix:\033[0m "
read table_prefix

# Copy/replace database-example.php to database.php
mv ./config/database-example.php ./config/database.php

# Insert given information to database.php
find ./config/database.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#db_host#)/$db_host/g" {} >/dev/null 2>&1 \;
find ./config/database.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#db_name#)/$db_name/g" {} >/dev/null 2>&1 \;
find ./config/database.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#db_user#)/$db_user/g" {} >/dev/null 2>&1 \;
find ./config/database.php -type f ! -name "setup.sh" -exec sed -i '' -e "s:(#db_password#):$db_password:g" {} >/dev/null 2>&1 \;
find ./config/database.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#table_prefix#)/$table_prefix/g" {} >/dev/null 2>&1 \;



#
##
### COOKIE DOMAIN
##
#

echo "\n\033[34m\033[1mCookie domain (usally same as website url):\033[0m "
read cookie_domain

mv ./config/cookie-example.php ./config/cookie.php
find ./config/cookie.php -type f ! -name "setup.sh" -exec sed -i '' -e "s:(#cookie_domain#):$cookie_domain:g" {} >/dev/null 2>&1 \;

#
##
### COMPOSER (uppdatera package name osv)
##
#

echo "\n\033[34m\033[1mComposer name (vendor/package):\033[0m "
read composer_project

echo "\n\033[34m\033[1mComposer license:\033[0m "
read composer_license

echo "\n\033[34m\033[1mComposer author name:\033[0m "
read composer_author_name

echo "\n\033[34m\033[1mComposer author email:\033[0m "
read composer_author_email

find ./composer.json -type f ! -name "setup.sh" -exec sed -i '' -e "s:(#composer_project#):$composer_project:g" {} >/dev/null 2>&1 \;
find ./composer.json -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#composer_license#)/$composer_license/g" {} >/dev/null 2>&1 \;
find ./composer.json -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#composer_author_name#)/$composer_author_name/g" {} >/dev/null 2>&1 \;
find ./composer.json -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#composer_author_email#)/$composer_author_email/g" {} >/dev/null 2>&1 \;






echo "\n\033[34m\033[1mAnswer the following questions with y/n…\033[0m "

#
##
### CACHE
##
#
mv ./config/cache-example.php ./config/cache.php

# Memcached
read -p "Do you wish to use memcached (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        find ./config/cache.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#cache_memcached#)/true/g" {} >/dev/null 2>&1 \;
    ;;
    * )
         find ./config/cache.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#cache_memcached#)/false/g" {} >/dev/null 2>&1 \;
    ;;
esac

# Varnish
read -p "Are you using varnish (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo "\033[34m\033[1mVarnish servers IP-address:\033[0m "
        read cache_varnish_ip

        find ./config/cache.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/(#cache_varnish_ip#)/$cache_varnish_ip/g" {} >/dev/null 2>&1 \;
    ;;
    * )
         find ./config/cache.php -type f ! -name "setup.sh" -exec sed -i '' -e "s/define('VHP_VARNISH_IP', '(#cache_varnish_ip#)');/\/\/ define('VHP_VARNISH_IP', '');/g" {} >/dev/null 2>&1 \;
    ;;
esac

#
##
### DEVELOPER
##
#

read -p "Do you wish to activate developer mode (WP_DEBUG in config/developer.php) (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        mv ./config/developer-example.php ./config/developer.php
    ;;
esac

#
##
### MULTISITE
##
#
multisite_prepare="false"

read -p "Do you wish to prepare the config files to setup a multisite (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        mv ./config/multisite-example.php ./config/multisite.php
        multisite_prepare="true"
    ;;
esac

#
##
### TIME CONSUMING TASKS COMES LAST
##
#
echo "\n\033[34m\033[1mLean back while I set things up…\033[0m"

# Run composer install
composer install

# Get salts
touch ./config/salts.php
echo "<?php\n" >> ./config/salts.php
curl https://api.wordpress.org/secret-key/1.1/salt/ >> ./config/salts.php
rm ./config/salts-example.php

#
##
### CLEAN UP
##
#
rm setup.sh
find . -maxdepth 1 -name '*.DS_Store' -delete

# All done
if [ "$multisite_prepare" == "true" ]; then
    echo "\n\n\033[43m\033[1mNote: to complete the multisite setup you will need to run the multisite installation through wp-admin after the standard WordPress install is completed.\033[0m\n"
fi

echo "\n\033[92m\033[1mAll done. Please go ahead and run the WordPress install in your browser.\033[0m"
