FROM jakzal/phpqa:alpine
LABEL maintainer="kontakt@raspberryvision.pl"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
