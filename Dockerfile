FROM golang:1.13.6-alpine

WORKDIR /go/src

COPY ./src /go/src

RUN apk update && apk add git 
RUN go get -u github.com/labstack/gommon/color


