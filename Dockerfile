FROM alpine:latest

RUN apk add --no-cache diffutils git

ADD . /golang-template
WORKDIR /golang-template

ENTRYPOINT ["/golang-template/entrypoint.sh"]
