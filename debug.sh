#!/usr/bin/env bash

CMD=$1

if [[ $CMD == 'install' ]]; then
    helm install -f debug-vals.yml -n csi metal-csi-debug charts/metal-csi
elif [[ $CMD == 'uninstall' ]]; then
    helm uninstall -n csi metal-csi-debug
fi
