FROM ubuntu:precise

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 libapache2-mod-php5 git
RUN a2enmod rewrite
RUN a2enmod php5
RUN git clone https://github.com/gilbitron/Pico.git /var/pico

ADD conf/php.ini etc/php5/apache2/php.ini
ADD conf/000-default etc/apache2/sites-enabled/000-default
ADD conf/ports.conf etc/apache2/ports.conf

ENTRYPOINT /usr/sbin/apache2ctl -D FOREGROUND
