FROM golang:alpine AS builder

RUN apk update && \
    apk add git build-base && \
    rm -rf /var/cache/apk/* && \
    mkdir -p "$GOPATH/src/github.com/bitnami-labs/kubewatch"

ADD . "$GOPATH/src/github.com/bitnami-labs/kubewatch"

RUN cd "$GOPATH/src/github.com/bitnami-labs/kubewatch" && \
    CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=5 go build -a --installsuffix cgo --ldflags="-s" -o /kubewatch

FROM alpine
RUN apk add --update ca-certificates

COPY --from=builder /kubewatch /bin/kubewatch
ENV SLACK_TOKEN='tehehe'
ENV SLACK_CHANNEL='#tehehe'

ENTRYPOINT ["/bin/kubewatch"]