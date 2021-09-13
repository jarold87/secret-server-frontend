FROM node:12.16.2

ADD . /var/www/secret-app
WORKDIR /var/www/secret-app

COPY build/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN npm ci
RUN npm run build

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
