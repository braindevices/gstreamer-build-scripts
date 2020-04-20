#!/usr/bin/env bash
set -e
target_tag="$1"
only_gstreamer="$2"
build_root="${HOME}/Projects/gstreamer/builds"
src_root="${HOME}/Projects/gstreamer"
export PKG_CONFIG_PATH="${HOME}/opt/gstreamer-all/lib/pkgconfig:${PKG_CONFIG_PATH}"
echo "target tag/branch=${target_tag}"
if [ ${only_gstreamer} = "yes" ]
then
    modules=(
        gstreamer
    )
else
    modules=(
        gst-plugins-base
        gst-plugins-good
        gst-plugins-ugly
        gst-plugins-bad
        gst-libav
        gst-rtsp-server
    )
fi
for module in "${modules[@]}"
do
    module_path="${src_root}/${module}"
    build_path="${build_root}/${module}-${target_tag}"
    cd "${module_path}"
    git checkout "${target_tag}"
    mkdir -p "${build_path}"
    cd "${build_path}"
    ${module_path}/autogen.sh --debug
done
