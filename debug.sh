#!/usr/bin/env bash

CMD=$1

if [[ $CMD == 'install' ]]; then
    helm install -f debug-vals.yml -n csi zed-csi-debug charts/zed-csi
elif [[ $CMD == 'uninstall' ]]; then
    helm uninstall -n csi zed-csi-debug
fi
