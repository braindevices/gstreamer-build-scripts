#!/usr/bin/env bash
set -e
target_tag="$1"
build_repo="$2"
build_root="${GST_BUILD_ROOT}"
src_root="${GST_SRC_ROOT}"
export PKG_CONFIG_PATH="${GST_INSTALL_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"
echo "target tag/branch=${target_tag}"
if [ ${build_repo} = "gstreamer" ]
then
    modules=(
        gstreamer
    )
elif [ ${build_repo} = "pluginbase" ]
then
    modules=(
        gst-plugins-base
    )
elif [ ${build_repo} = "plugins" ]
then
    modules=(
        gst-plugins-good
        gst-plugins-ugly
        gst-plugins-bad
        gst-libav
    )
elif [ ${build_repo} = "rtsp" ]
then
    modules=(
        gst-rtsp-server
    )
else
    exit 1
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
