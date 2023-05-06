# Définir l'image de base
FROM php:8.0-apache

# Copier les fichiers de l'application dans le conteneur
WORKDIR /var/www/html

COPY . .

# Installer les dépendances de l'application
RUN apt-get update && \
    apt-get install -y \
        libicu-dev \
        libzip-dev \
        zip \
        unzip \
        wget \
        gnupg2 \
        git && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl  zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN wget -qO-  https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list


RUN apt-get -y install unixodbc-dev

RUN ACCEPT_EULA=Y apt-get -y install msodbcsql17

RUN pecl install sqlsrv 

RUN pecl install pdo_sqlsrv

RUN echo "extension=sqlsrv.so" >> /usr/local/etc/php/conf.d/sqlsrv.ini && \
    echo "extension=pdo_sqlsrv.so" >> /usr/local/etc/php/conf.d/pdo_sqlsrv.ini && \
    docker-php-ext-enable sqlsrv pdo_sqlsrv

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set document root
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Expose port 80
EXPOSE 80
