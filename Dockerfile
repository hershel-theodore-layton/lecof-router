FROM hersheltheodorelayton/hhvm-full:25.6.0
ENV COMPOSER=composer.dev.json

WORKDIR /mnt/project

RUN chown ubuntu -R /mnt/project

USER ubuntu

COPY composer.dev.json /mnt/project/composer.dev.json
RUN composer install
COPY . /mnt/project
COPY .hhconfig /etc/hh.conf

USER root

CMD ["vendor/bin/pha-linters-server.sh", "-g", "-b", "./vendor/hershel-theodore-layton/portable-hack-ast-linters-server/bin/portable-hack-ast-linters-server-bundled.resource"]