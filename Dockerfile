FROM php:7.4

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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
ENV NODE_VERSION 10.13.0
ENV NVM_DIR /usr/local/nvm

RUN mkdir ${NVM_DIR} && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash && \
    . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /var/www
