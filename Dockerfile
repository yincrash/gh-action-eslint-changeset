FROM node:16.14.2

RUN apt-get install git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]