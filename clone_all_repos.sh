#!/usr/bin/env bash
set -e

./gst_check_env.sh

src_root="${GST_SRC_ROOT}"
cd "${src_root}"
modules="${GST_REPO_NAMES}"
for module in ${modules}; do
  git clone https://gitlab.freedesktop.org/gstreamer/$module ;
done

# consider gst-python gst-devtools
