FROM golang:1.20-alpine AS dTrackBuilder
LABEL stage=dTrackBuilder

COPY ${PWD}/d-track-back /go/src/back
WORKDIR /go/src/back
RUN go build -mod vendor -v -o ./bin/service.alpine ./cmd

FROM alpine:3 AS dTrackProd
COPY --from=dTrackBuilder /go/src/back/bin/service.alpine /usr/local/bin/dtrack.alpine

ENTRYPOINT ["dtrack.alpine"]
