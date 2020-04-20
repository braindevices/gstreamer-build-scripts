#!/usr/bin/env bash
set -e
target_tag="$1"
echo "target tag/branch=${target_tag}"
modules="gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-libav gst-rtsp-server"
for module in ${modules}; do
  cd "${module}"
  git checkout "${target_tag}"
  cd ..
done
