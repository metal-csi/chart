#!/usr/bin/env bash
helm template --debug charts/metal-csi -f debug-vals.yml >debug.yml
kubeval debug.yml
