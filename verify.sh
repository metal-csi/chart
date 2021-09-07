#!/usr/bin/env bash
helm template --debug . >debug.yml
kubeval debug.yml
