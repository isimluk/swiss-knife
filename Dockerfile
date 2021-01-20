FROM registry.centos.org/centos/centos:8

RUN \
    dnf install -y golang-bin podman && \
    dnf clean all

ENV GO111MODULE on

RUN go get -u -v github.com/openshift/oc/cmd/oc
