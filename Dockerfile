FROM alpine:3.14

# Install the certs that we need.
RUN apk update \
    && apk add --no-cache ca-certificates wget \
    && rm /var/cache/apk/*

RUN wget -O./helm-linux-amd64.tar.gz https://get.helm.sh/helm-v3.6.3-linux-amd64.tar.gz && \
      tar -xzvf ./helm-linux-amd64.tar.gz && \
      cp linux-amd64/helm /usr/local/bin/. && \
      rm -rf linux-amd64

VOLUME /tmp/linting

ENV CHARTMUSEUM_HOST "chartmuseum.default"

COPY lint.sh .
COPY global.yaml .
COPY test-values.yaml .

RUN chmod +x lint.sh

CMD ["./lint.sh", "/tmp/linting"]
