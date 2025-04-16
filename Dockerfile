# 使用官方 PHP Apache 镜像
FROM php:7.2-apache

# 安装必要的 PHP 扩展
RUN docker-php-ext-install pdo pdo_mysql

# 复制项目文件到容器
COPY . /var/www/html

# 安装 Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 安装依赖（即使没有 composer.lock）
RUN composer install --no-dev --optimize-autoloader

# 设置 Apache 配置
RUN a2enmod rewrite
COPY .htaccess /var/www/html/.htaccess

# 暴露端口
EXPOSE 80
