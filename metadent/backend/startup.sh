echo "Starting Metadent Backend..."
echo ""

echo "Copying php.ini..."
cp /home/php.ini /usr/local/etc/php/conf.d/php.ini
echo ""

echo "Copying default..."
cp /home/default /etc/nginx/sites-enabled/default
echo ""

# Restart the php engine of the server
echo "Restarting php-fpm..."
pkill -o -USR2 php-fpm
echo ""
echo "php-fpm restarted"
echo ""

# Restart nginx
echo "Restarting nginx..."
service nginx restart
echo ""
echo "nginx restarted"
echo ""