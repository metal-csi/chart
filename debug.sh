#!/usr/bin/env bash

CMD=$1

if [[ $CMD == 'install' ]]; then
    helm install -f debug-vals.yml -n csi zed-csi-debug .
elif [[ $CMD == 'uninstall' ]]; then
    helm uninstall -n csi zed-csi-debug
fi
