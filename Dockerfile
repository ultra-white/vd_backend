FROM php:8.3-fpm

# Установка зависимостей и нужных расширений
RUN apt-get update && apt-get install -y \
    git unzip curl libpq-dev libzip-dev zip libicu-dev \
    && docker-php-ext-install pdo pdo_pgsql zip intl

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Рабочая директория
WORKDIR /var/www

# Копирование исходников
COPY . .

# Установка зависимостей Laravel
RUN composer install --no-dev --optimize-autoloader

# Генерация ключа и кэшей
RUN php artisan key:generate \
    && php artisan config:cache \
    && php artisan route:cache

EXPOSE 8000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
