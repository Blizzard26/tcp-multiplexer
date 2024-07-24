# Build the application from source
FROM golang:latest AS build-stage

ARG CGO_ENABLED=0 

WORKDIR /app

COPY . ./

RUN go mod tidy
RUN go build -o tcp-multiplexer

FROM alpine AS build-release-stage

WORKDIR /

COPY --from=build-stage /app/tcp-multiplexer /tcp-multiplexer

ENTRYPOINT ["/tcp-multiplexer"]