FROM ubuntu:21.10

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
EXPOSE 80

RUN apt-get update && \
apt-get install -y apache2 default-jre php php-mysql \ 
php-all-dev php-zip php-gd php-curl clamav libreoffice-common \ 
unoconv p7zip-full imagemagick unrar-free ffmpeg tesseract-ocr \ 
meshlab dia pandoc poppler-utils zip unzip gosu wget && \
apt-get clean && \ 
rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_PID_FILE  /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2

RUN mkdir -p $APACHE_RUN_DIR && \
mkdir -p $APACHE_LOCK_DIR && \
mkdir -p $APACHE_LOG_DIR


COPY uploads.ini /etc/php/8.0/apache2/conf.d/uploads.ini
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

RUN mkdir /var/www/html/HRProprietary && \
mkdir /var/www/html/HRProprietary/HRConvert2 && \
mkdir /home/converter && \
chmod -R 0755 /home/converter && \
chown -R www-data /home/converter && \
chgrp -R www-data /home/converter

RUN wget https://github.com/zelon88/HRConvert2/archive/v2.9.2.zip -O /tmp/2.9.2.zip && \
unzip /tmp/2.9.2.zip -d /tmp/ && \
mv /tmp/HRConvert2-2.9.2/* /var/www/html/HRProprietary/HRConvert2 && \
rm -rf /var/www/html/index.html

COPY index.html /var/www/html/index.html

RUN chmod -R 0755 /var/www && \
chown -R www-data /var/www && \
chgrp -R www-data /var/www && \
rm -rf /var/www/html/HRProprietary/HRConvert2/config.php

COPY config.php /var/www/html/HRProprietary/HRConvert2/config.php

COPY unoconv_start.sh /unoconv_start.sh

RUN chmod -R 0755 /unoconv_start.sh && \
chown -R www-data /unoconv_start.sh && \
chgrp -R www-data /unoconv_start.sh && \
chmod +x /unoconv_start.sh

COPY wait-for-it.sh /wait-for-it.sh

RUN chmod -R 0755 /wait-for-it.sh && \
chown -R www-data /wait-for-it.sh && \
chgrp -R www-data /wait-for-it.sh && \
chmod +x /wait-for-it.sh

RUN wget https://raw.githubusercontent.com/zelon88/HRConvert2/master/rc.local -O /etc/rc.local && \
chmod +x /etc/rc.local
RUN /usr/bin/soffice --headless --accept="socket,host=127.0.0.1,port=$soffice_port;urp;" --nofirststartwizard &
