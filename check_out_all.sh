#!/usr/bin/env bash
set -e
target_tag="$1"
echo "target tag/branch=${target_tag}"
for module in gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-libav; do
  cd "${module}"
  git checkout "${target_tag}"
  cd ..
done
