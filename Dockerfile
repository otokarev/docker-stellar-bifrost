FROM golang

# deploy bifrost binary
ADD initial_balance_fix.patch /
RUN mkdir -p /go/src/github.com/stellar/ \
    && git clone https://github.com/stellar/go.git /go/src/github.com/stellar/go \
    && cd /go/src/github.com/stellar/go \
    && git checkout 1c3482fd5918eb7ffcac9f06dc2afc28788509c4 \
    && git apply /initial_balance_fix.patch \
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
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]

EXPOSE 8000