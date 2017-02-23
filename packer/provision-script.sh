#!/bin/bash

# make sure we're ready to run things before we try to run things
# this seems like a pretty bad way of doing it
# ¯\_(ツ)_/¯ 
while [[ `/sbin/runlevel | cut -d " " -f 2` != 3 ]]; do
	sleep 1
done

sudo yum -y update
sudo yum -y install httpd24 httpd24-tools mod24_ssl
sudo yum -y install php70 php70-cli php70-common php70-devel php70-json php70-mbstring php70-mcrypt php70-odbc php70-opcache php70-pdo php70-pecl-apcu php70-pecl-apcu-devel php70-pecl-imagick php70-pecl-imagick-devel php70-pecl-oauth php70-pecl-ssh2 php70-pecl-uuid php70-pecl-yaml php70-pgsql php70-xml php70-xmlrpc php70-zip 
sudo yum -y install git

sudo chkconfig httpd on

sudo git clone https://github.com/neldridge/neldridge.net.git /var/www/neldridge.net
sudo chown -R apache /var/www

if [[ -a "/var/www/neldridge.net/neldridge.net.conf" ]]; then
	sudo ln -s /var/www/neldridge.net/neldridge.net.conf /etc/httpd/conf.d/
fi
sudo rm /etc/httpd/conf.d/welcome.conf
sudo chmod -R 775 /var/www/neldridge.net

sudo service httpd start
echo 'MAILTO=nicholas.eldridge@gmail.com' | sudo tee -a /etc/crontab

echo '*/5  *  *  *  * apache cd /var/www/neldridge.net && /usr/bin/git pull 2>&1 >/dev/null' | sudo tee -a /etc/crontab

exit 0
