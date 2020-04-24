#!/usr/bin/env bash
set -e

./gst_check_env.sh

target_tag="$1"
echo "target tag/branch=${target_tag}"

reset_before_checkout="$2"

src_root="${GST_SRC_ROOT}"
cd "${src_root}"
if [ ! -d gst-build ]
then
    git clone https://gitlab.freedesktop.org/gstreamer/gst-build
fi

cd "${module}"
git fetch origin
if [ "${reset_before_checkout}" == "yes" ]
    git reset --hard
fi
git checkout "${target_tag}"
git submodule sync
git submodule update --init --recursive
cd ..
