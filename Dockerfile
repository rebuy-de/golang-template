FROM alpine:3.9

RUN apk add --no-cache diffutils git

ADD . /golang-template
WORKDIR /golang-template

ENTRYPOINT ["/golang-template/entrypoint.sh"]
