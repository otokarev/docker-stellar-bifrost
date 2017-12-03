FROM golang:alpine as builder

# deploy bifrost binary
ADD initial_balance_fix.patch /
RUN mkdir -p /go/src/github.com/stellar/ \
    && apk add --no-cache git curl wget mercurial make gcc  musl-dev linux-headers\
    && git clone https://github.com/stellar/go.git /go/src/github.com/stellar/go \
    && cd /go/src/github.com/stellar/go \
    && git checkout d25748009082df14197add9cc3a2d6657bfeaf07 \
    && git apply /initial_balance_fix.patch \
    && curl https://glide.sh/get | sh \
    && glide install \
    && go install github.com/stellar/go/services/bifrost

# deploy config manager
RUN wget -nv -O /usr/local/bin/confd \
    https://github.com/kelseyhightower/confd/releases/download/v0.14.0/confd-0.14.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd

# deploy db init script
ADD initbifrost /go/src/github.com/stellar/initbifrost
RUN go get github.com/lib/pq \
    && go install github.com/stellar/initbifrost

FROM alpine:latest

ADD confd /etc/confd
COPY --from=builder /go/bin/bifrost /go/bin/bifrost
COPY --from=builder /go/bin/initbifrost /go/bin/initbifrost
COPY --from=builder /go/src/github.com/stellar/go/services/bifrost/database/migrations/01_init.sql /go/src/github.com/stellar/go/services/bifrost/database/migrations/01_init.sql
COPY --from=builder /usr/local/bin/confd /usr/local/bin/confd

ADD entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]

EXPOSE 8000