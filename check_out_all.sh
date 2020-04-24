#!/usr/bin/env bash
set -e

./gst_check_env.sh

src_root="${GST_SRC_ROOT}"

target_tag="$1"
echo "target tag/branch=${target_tag}"
cd "${src_root}"
modules="${GST_REPO_NAMES}"
for module in ${modules}; do
    cd "${module}"
    git fetch origin
    #git reset --hard
    git checkout "${target_tag}"
    git submodule sync
    git submodule update --init --recursive
    cd ..
done
