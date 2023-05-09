FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/kolkata

# Install required packages
RUN apt-get update && apt-get install -y apache2 mariadb-server mariadb-client php php-mysql libapache2-mod-php curl

# Start MySQL service
RUN service mysql start

# Download and extract Mediawiki
RUN curl -O https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.3.tar.gz && \
   tar xvzf mediawiki-1.39.3.tar.gz && \
   rm mediawiki-1.39.3.tar.gz && \
   mv mediawiki-1.39.3 /var/www/html/mediawiki
RUN apt-get update && \
    apt-get install -y php-gd php-mbstring php-xml php-intl php-opcache php-fileinfo && \
    rm -rf /var/lib/apt/lists/*

# Configure Apache
RUN a2enmod rewrite && \
     chown -R www-data:www-data /var/www/html/mediawiki && \
     sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/apache2/mods-enabled/dir.conf

# Configure MySQL
COPY mediawiki.sql /tmp/mediawiki.sql
RUN service apache2 restart

# Expose ports
EXPOSE 80

# Start services
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

