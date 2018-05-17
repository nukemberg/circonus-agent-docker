FROM golang:1.10-stretch
RUN go get -v github.com/circonus-labs/circonus-agent
WORKDIR /go/src/github.com/circonus-labs/circonus-agent
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo .

FROM scratch
VOLUME [ "/plugins", "/state" ]
WORKDIR /opt/circonus
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=0 /go/src/github.com/circonus-labs/circonus-agent/circonus-agent /opt/circonus/circonus-agent
ENTRYPOINT [ "/opt/circonus/circonus-agent" ]
CMD ["-p", "/plugins", "--check-metric-state-dir", "/state"]
