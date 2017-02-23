#!/bin/bash

# make sure we're ready to run things before we try to run things
# this seems like a pretty bad way of doing it
# ¯\_(ツ)_/¯ 
while [[ `/sbin/runlevel | cut -d " " -f 2` != 3 ]]; do
	sleep 1
done

# Run level should be good now to do things
sudo yum -y update
sudo yum -y install httpd httpd24-tools mod24_ssl
sudo yum -y install php70 php70-cli php70-common php70-devel php70-json php70-mbstring php70-mcrypt php70-odbc php70-opcache php70-pdo php70-pecl-apcu php70-pecl-apcu-devel php70-pecl-imagick php70-pecl-imagick-devel php70-pecl-oauth php70-pecl-ssh2 php70-pecl-uuid php70-pecl-yaml php70-pgsql php70-xml php70-xmlrpc php70-zip 
sudo yum -y install git

sudo chkconfig httpd on

sudo -u apache -- git clone https://github.com/neldridge/neldridge.net.git /var/www/neldridge.net
sudo ln -s /etc/httpd/conf.d/ /var/www/neldridge.net/neldridge.net.conf
sudo rm /etc/httpd/conf.d/welcome.conf
sudo chown -R apache:apache /var/www
sudo chmod -R 775 /var/www/neldridge.net

sudo service httpd start
echo 'MAILTO=nicholas.eldridge@gmail.com' >> /etc/crontab

echo '*/5  *  *  *  * apache cd /var/www/neldridge.net && /usr/bin/git pull 2>&1 >/dev/null' >> /etc/crontab

exit 0
