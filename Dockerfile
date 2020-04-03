FROM golang:alpine AS builder

COPY . /go/src/github.com/m-richo/go-headers

# If we don't disable CGO, the binary won't work in the scratch image. Unsure why?
RUN CGO_ENABLED=0 go install github.com/m-richo/go-headers

FROM scratch

COPY --from=builder /go/bin/go-headers /go/bin/go-headers

# Export necessary port
EXPOSE 3000

ENTRYPOINT ["/go/bin/go-headers"]

