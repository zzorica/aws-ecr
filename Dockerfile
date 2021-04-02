FROM docker:20.10.5
LABEL name="aws-ecr"
LABEL version="0.1"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update python3 py-pip coreutils \
    && rm -rf /var/cache/apk/* \
    && pip install awscli==1.19.43

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]