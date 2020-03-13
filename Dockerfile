FROM jakzal/phpqa:alpine
LABEL maintainer="kontakt@raspberryvision.pl"

ENV PHPQA_HOME_DIR=${HOME_DIR:-~/phpqa}
ENV PHPQA_CODE_DIR=${CODE_DIR:-$PHPQA_HOME_DIR/code}
ENV PHPQA_LOGS_DIR=${LOGS_DIR:-$PHPQA_HOME_DIR/logs}

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
