#!/usr/bin/env bash
set -e
modules="gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-libav gst-rtsp-server"
for module in ${modules}; do
  git clone https://gitlab.freedesktop.org/gstreamer/$module ;
done

# consider gst-python gst-devtools
