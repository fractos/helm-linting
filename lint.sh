#!/bin/sh

FOLDER=$1

echo "$CHARTMUSEUM_PORT_80_TCP_ADDR $CHARTMUSEUM_HOST" >> /etc/hosts

mkdir -p /tmp/working

cd /tmp/working || exit

cp -r "$FOLDER"/* .

helm dependency update

helm template . --debug --values /global.yaml --values /test-values.yaml

helm lint --values /global.yaml --values /test-values.yaml
