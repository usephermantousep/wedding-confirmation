FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install extension
RUN docker-php-ext-install pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Set working directory
WORKDIR /var/www/html

# Copy files to container
COPY . .

# Install dependencies
RUN composer install

# Expose port
EXPOSE 8000

# Run command
CMD ["php", "artisan", "serve", "--host", "0.0.0.0", "--port", "8000"]
