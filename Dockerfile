FROM node:12.16.2

ADD . /var/www/secret-app
WORKDIR /var/www/secret-app

RUN npm install
RUN npm run build

COPY build/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["entrypoint.sh"]
