#!/usr/bin/env bash
set -e

src_root="/data/LingBuilds/gstreamer/repos"

target_tag="$1"
echo "target tag/branch=${target_tag}"
cd "${src_root}"
modules="gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-libav gst-rtsp-server"
for module in ${modules}; do
    cd "${module}"
    git checkout "${target_tag}"
    git submodule sync
    git submodule update --init --recursive
    cd ..
done
