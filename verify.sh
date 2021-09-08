#!/usr/bin/env bash
helm template --debug charts/zed-csi >debug.yml
kubeval debug.yml
