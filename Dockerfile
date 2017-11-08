FROM golang

# deploy bifrost binary
ADD stellar-monorepo /go/src/github.com/stellar/go
RUN cd /go/src/github.com/stellar/go \
    && curl https://glide.sh/get | sh \
    && glide install \
    && go install github.com/stellar/go/services/bifrost

# deploy config manager
ADD confd /etc/confd
RUN wget -nv -O /usr/local/bin/confd \
    https://github.com/kelseyhightower/confd/releases/download/v0.14.0/confd-0.14.0-linux-amd64 \
    && chmod +x /usr/local/bin/confd

# deploy db init script
ADD initbifrost /go/src/github.com/stellar/initbifrost
RUN go get github.com/lib/pq \
    && go install github.com/stellar/initbifrost

ADD entry.sh /entry.sh
ENTRYPOINT ["/bin/sh", "/entry.sh"]

EXPOSE 3000