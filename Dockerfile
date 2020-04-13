FROM centos:7
LABEL MAINTAINER Tony Nguyen <tony@sendplex.com>
LABEL Description="Gearmand Monitor System" \
	Usage="Swarm" \
	Version="1.0"

# Install epel
RUN yum -y install epel-release

# Install RPMs
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm


# Install Web Server
RUN yum -y update && yum clean all
RUN yum -y install httpd && yum clean all

# Install development tools and needed tools
RUN yum -y install \
gcc \
make \
openssl-devel \
python34 \
python34-devel \
python34-setuptools \
python-pip \
python-setuptools \
nano \
wget \
vim\
vim-enhanced \
bash-completion \
yum-utils \
git

RUN yum groupinstall -y base && yum groupinstall -y 'Development Tools'
RUN yum clean all

# Networking
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# Using php7.2
RUN yum-config-manager --enable remi-php72

# Install php
RUN yum install -y \
	php \
	php-devel \
	php-pear \
	php-common \
	php-dba \
	php-gd \
	php-intl \
	php-ldap \
	php-mbstring \
	php-mysqlnd \
	php-odbc \
	php-pdo \
	php-pecl-memcache \
	php-pgsql \
	php-pspell \
	php-recode \
	php-snmp \
	php-soap \
	php-xml \
	php-xmlrpc

# Install mongodb and adding it to php.ini
RUN sh -c 'printf "\n" | pecl install mongodb'
RUN sh -c 'echo short_open_tag=On >> /etc/php.ini'
RUN sh -c 'echo extension=mongodb.so >> /etc/php.ini'

# Custom environment variables defined here
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC

# Install pip
RUN easy_install pip
RUN pip install --upgrade pip
RUN pip install supervisor

# Adding files to the webserver
COPY /files/ /var/www/html/


# OLD: changing htaccess for mod_rewrite
RUN sh -c "sed -i 's/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf"
RUN sh -c "sed -i 's/AllowOverride none/AllowOverride All/g' /etc/httpd/conf/httpd.conf"

#Change storage permission
RUN chown apache:apache -R /var/www/html

#Run composer
RUN cd /var/www/html && php composer.phar require --no-interaction --optimize-autoloader


# Adding custom supervisord configuration.
ADD supervisord.conf /etc/

# Exposed ports: ssh, http, https, mongodb, mysql
EXPOSE 80 443 8888

# Running supervisord
CMD ["supervisord", "-n"]
