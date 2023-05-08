#!/bin/bash

set -e -x

cd docs/

# Clean up old packages
rm ./* || true

# Package subcharts
for package in ../charts/*; do
  helm package "$package"
  pushd "$package"
  helm dep up
  popd
done

# Update index
cd ..
helm repo index --url https://acorn-io.github.io/hub-system-charts/ ./docs
