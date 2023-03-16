FROM golang:1.19.0-alpine3.16 AS builder

WORKDIR /src

COPY go.mod /src/go.mod
COPY go.sum /src/go.sum
COPY main.go /src/main.go
COPY exporter /src/exporter

RUN go env -w GOPROXY=https://goproxy.cn,direct && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o /src/predixy_exporter


FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk update && \
    apk --no-cache add tzdata ca-certificates && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

COPY --from=builder /src/predixy_exporter /usr/local/bin

RUN addgroup -g 1000 rf && \
    adduser -D -u 1000 -G rf rf && \
    chown rf:rf /usr/local/bin/predixy_exporter
USER rf

ENTRYPOINT ["/usr/local/bin/predixy_exporter"]

