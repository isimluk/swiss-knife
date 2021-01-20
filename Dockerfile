FROM registry.centos.org/centos/centos:8 AS builder

RUN \
    dnf install -y golang-bin git make

ENV GO111MODULE on

#RUN go get -u -v github.com/openshift/oc/cmd/oc 6f8f260853ad23a1edeb7ee622da764e6b711e37
RUN git clone https://github.com/openshift/oc
DIR /root/oc
RUN make "WHAT=cmd/oc"


FROM registry.centos.org/centos/centos:8

COPY --from=builder /root/oc/oc /bin/
# TODO copy contrib/completions/bash/oc

RUN \
    dnf install -y git podman && \
    dnf clean all