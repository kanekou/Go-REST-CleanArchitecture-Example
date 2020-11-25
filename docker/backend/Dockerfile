# FROM golang:1.13.6-alpine
# 
# ENV GO111MODULE=on
# 
# WORKDIR /go/src
# 
# RUN apk update \
#     && apk add git \
#     && go build -o app \
#     && go get github.com/oxequa/realize
# 
FROM golang:alpine as build-reflex
RUN apk update && \
    apk upgrade && \
    apk add bash git && \
    rm -rf /var/cache/apk/*

RUN go get github.com/cespare/reflex

FROM golang:alpine
COPY --from=build-reflex /go/bin/reflex /go/bin/reflex

RUN apk update && \
    apk upgrade && \
    apk add bash git build-base && \
    rm -rf /var/cache/apk/*

ENV GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .




