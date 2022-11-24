FROM php:7.3-apache

WORKDIR /home/dev

COPY . .

RUN apt-get update -y \
    && apt-get install -y bzip2 git zip unzip

# Install composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer
RUN COMPOSER_ALLOW_SUPERUSER=1 \
    composer install

# Copy startup script
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod u+x /usr/local/bin/startup.sh

CMD ["/usr/local/bin/startup.sh"]