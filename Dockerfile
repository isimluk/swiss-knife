FROM registry.centos.org/centos/centos:8 AS builder

RUN \
    dnf install -y golang-bin git make

ENV GO111MODULE on

#RUN go get -u -v github.com/openshift/oc/cmd/oc 6f8f260853ad23a1edeb7ee622da764e6b711e37
RUN git clone --depth 1 https://github.com/openshift/oc
RUN cd oc && make "WHAT=cmd/oc"


FROM quay.io/slukasik/falcon-demo

COPY google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo

COPY --from=builder /oc/oc /bin/
# TODO copy contrib/completions/bash/oc

RUN \
    dnf install -y git podman google-cloud-sdk && \
    dnf clean all