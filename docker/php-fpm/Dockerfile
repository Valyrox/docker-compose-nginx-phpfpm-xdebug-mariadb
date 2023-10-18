FROM php:8.3.0RC4-fpm
WORKDIR "/app"

# Update
RUN apt-get update

# Install PHP extensions dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
        libmcrypt-dev \
        zlib1g-dev \
        libicu-dev \
        g++ \
        unixodbc-dev \
        libxml2-dev \
        libaio-dev \
        libmemcached-dev \
        freetds-dev \
        libonig-dev \
        libfreetype-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libssl-dev \
        libzip-dev \
        openssl \
        curl \
        wget \
        vim \
        git \
        unzip

# Install PHP extensions
RUN docker-php-ext-install zip pdo pdo_mysql mysqli iconv mbstring intl gd sockets pcntl ftp bcmath gettext

# Install Redis
RUN pecl install -o -f redis && docker-php-ext-enable redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
