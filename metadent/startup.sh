cp /home/php.ini /usr/local/etc/php/conf.d/php.ini

# Restart the php engine of the server
pkill -o -USR2 php-fpm
