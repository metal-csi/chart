#!/usr/bin/env bash
helm template --debug charts/zed-csi -f debug-vals.yml >debug.yml
kubeval debug.yml
