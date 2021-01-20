FROM registry.centos.org/centos/centos:8 AS builder

RUN \
    dnf install -y golang-bin git

ENV GO111MODULE on

RUN go get -u -v github.com/openshift/oc/cmd/oc

FROM registry.centos.org/centos/centos:8

COPY --from=builder /root/go/bin/* /bin/

RUN \
    dnf install -y git podman && \
    dnf clean all