#!/bin/bash
yum -y update
yum -y install httpd24 git
chkconfig httpd on
yum install -y php56 php56-cli php56-common php56-devl php56-gd php56-jsonc php56-mbstring php56-mcrypt php56-pdo php56-opcache php56-pecl-imagick php56-xml php56-soap php56-xml php56-xmlrpc php56-mysqlnd
yum install -y mysql
cd /var/www/ && git clone https://github.com/neldridge/neldridge.net.git
cd /etc/httpd/conf.d/ && ln -s /var/www/neldridge.net/neldridge.net.conf
rm /etc/httpd/conf.d/welcome.conf
service httpd start
echo 'MAILTO=nicholas.eldridge@gmail.com' >> /etc/crontab
echo '*/5  *  *  *  * root cd /var/www/neldridge.net && /usr/bin/git pull 2>&1 >/dev/null' >> /etc/crontab
