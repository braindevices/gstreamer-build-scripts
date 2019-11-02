#!/usr/bin/env bash
set -e
for module in gstreamer gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gst-libav; do
  git clone https://gitlab.freedesktop.org/gstreamer/$module ;
done
