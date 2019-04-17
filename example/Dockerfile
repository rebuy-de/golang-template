# Source: https://github.com/rebuy-de/golang-template

FROM golang:1.12-alpine as builder

RUN apk add --no-cache git make curl openssl

# Configure Go
ENV GOPATH=/go PATH=/go/bin:$PATH CGO_ENABLED=0 GO111MODULE=on
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

# Install Go Tools
RUN GO111MODULE= go get -u golang.org/x/lint/golint

# Install kubectl
RUN set -x \
 && curl -O https://storage.googleapis.com/kubernetes-release/release/v1.13.2/bin/linux/amd64/kubectl \
 && mv kubectl /usr/local/bin/kubectl \
 && chmod 755 /usr/local/bin/kubectl \
 && kubectl version --client

COPY . /src
WORKDIR /src
RUN set -x \
 && make test \
 && make build \
 && cp --dereference /src/dist/* /usr/local/bin/

RUN set -x \
 && kubernetes-deployment version \
 && k26r version

FROM alpine:latest
RUN apk add --no-cache ca-certificates

COPY --from=builder /usr/local/bin/* /usr/local/bin/

RUN adduser -D k26r
USER k26r
