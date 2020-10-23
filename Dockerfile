# Build
FROM golang:alpine as build-env

RUN apk --no-cache add git

RUN CGO_ENABLED=0 go get -v github.com/sl1pm4t/gcp-exec-creds


# Dockerfile
FROM busybox

WORKDIR /app

RUN mkdir /tmp/gcloud
COPY --from=build-env /go/bin/gcp-exec-creds /app/
ADD script.sh /app
ENTRYPOINT [ "/app/script.sh" ]
