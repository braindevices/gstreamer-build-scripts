#!/usr/bin/env bash
set -e

./gst_check_env.sh

target_tag="$1"
echo "target tag/branch=${target_tag}"

reset_before_checkout="$2"

src_root="${GST_SRC_ROOT}"
cd "${src_root}"

module="gst-build"
if [ ! -d "${module}" ]
then
    git clone https://gitlab.freedesktop.org/gstreamer/"${module}"
fi

cd "${module}"
git fetch origin
if [ "${reset_before_checkout}" == "yes" ]
then
    git reset --hard
fi
git checkout "${target_tag}"
git submodule sync
git submodule update --init --recursive
cd ..
