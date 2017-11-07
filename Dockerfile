FROM golang

RUN curl https://glide.sh/get | sh

ADD stellar-monorepo /go/src/github.com/stellar/go

WORKDIR /go/src/github.com/stellar/go
RUN glide install
RUN go install github.com/stellar/go/services/bifrost

ENTRYPOINT /go/bin/bifrost

EXPOSE 3000