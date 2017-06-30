FROM golang:rc

EXPOSE 6667/tcp 6697/tcp

RUN apt-get update && apt-get install -y git python-pip
RUN pip install j2cli[yaml]

RUN mkdir -p /go/src/github.com/oragono
WORKDIR /go/src/github.com/oragono

RUN git clone https://github.com/oragono/oragono.git
WORKDIR /go/src/github.com/oragono/oragono
RUN git submodule update --init
RUN go build oragono.go

COPY run.sh /go/src/github.com/oragono/oragono
COPY ircd.j2 /go/src/github.com/oragono/oragono

CMD ["./run.sh"]
