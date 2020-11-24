FROM golang:1.13.6-alpine

WORKDIR /go/src

COPY ./src /go/src

RUN apk update \
    && apk add git \
    && go build -o app \
    && go get github.com/oxequa/realize



