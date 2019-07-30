FROM php:7.3
LABEL maintainer="Júnior Garcia <itamarjr91@gmail.com>"

# PHP-related things
ENV COMPOSER_ALLOW_SUPERUSER 1

# Cypress dependencies
RUN apt update && \
    apt install libgtk-3-0 xvfb libgconf2-dev libxtst-dev libxss-dev libnss3 libasound2 -y --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# PHP-related install
RUN docker-php-ext-install bcmath && \
    curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# Node install
ENV NODE_VERSION v10.13.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN nvm install ${NODE_VERSION}

WORKDIR /var/www
