#!/usr/bin/env bash
set -e
src_root="/data/LingBuilds/gstreamer/repos"
cd "${src_root}"
modules="gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-libav gst-rtsp-server"
for module in ${modules}; do
  git clone https://gitlab.freedesktop.org/gstreamer/$module ;
done

# consider gst-python gst-devtools
