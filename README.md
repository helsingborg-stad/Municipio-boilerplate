Municipio Boilerplate
=====================

A boilerplate that installs WordPress together with themes and plugins for creating a Municipio site.

## Getting started

This is a simple guide on how to get started with the Municipio Boilerplate.

Make sure you have [Composer](http://www.getcomposer.org) installed on your machine.

1. Open the ```composer.json``` file and change the ```name``` and ```authors``` values.
2. In the Terminal, ```cd``` to the Municipio Boilerplate folder on your system.
3. Install Composer dependencies by running ```composer install```.
4. Wait until all dependencies have been installed.
5. Run ```mv config/database-example.php config/database.php``` to rename the database config file. Then open it in a text editor of your choise.
6. Fill in your database details and change the ```$table_prefix``` variable value to the table prefix you want on your database tables.
7. ```mv config/salts-example.php config/salts.php``` to rename the salts config file. Then open it in a text editor of your choise.
8. Go to https://api.wordpress.org/secret-key/1.1/salt/ to generate salts (or do it manually). Copy and paste (replace old) to the salts config file.

### Multisite?

If you want your install to be a multisite, please follow the above "getting started" stes and then do the following:

1. Run ```mv config/multisite-example.php config/multisite.php``` to rename the multisite config file.
