#!/usr/bin/env bash
set -e
target_tag="$1"
build_repo="$2"
datestr="$(date +"%Y%m%d-%H%M%S")"
logfile="${datestr}.log"
build_root="${GST_BUILD_ROOT}"
src_root="${GST_SRC_ROOT}"
install_prefix="${GST_INSTALL_PATH}"

export PKG_CONFIG_PATH="${GST_INSTALL_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"
echo "target tag/branch=${target_tag}"

if [ ${build_repo} = "gstreamer" ]
then
    modules=(
        gstreamer
    )
    config_flags=("")
elif [ ${build_repo} = "pluginbase" ]
then
    modules=(
        gst-plugins-base
    )
    config_flags=(
        "--enable-pango --disable-wayland --disable-gtk-doc"
    )
elif [ ${build_repo} = "plugins" ]
then
    modules=(
        gst-plugins-good
        gst-plugins-ugly
        gst-plugins-bad
        gst-libav
    )
    config_flags=(
        ""
        ""
        "--enable-pango"
        ""
    )
elif [ ${build_repo} = "rtsp" ]
then
    modules=(
        gst-rtsp-server
    )
    config_flags=("")
else
    exit 1
fi
for index in ${!modules[*]}
do
    echo "index=$index"
    module="${modules[$index]}"
    module_path="${src_root}/${module}"
    build_path="${build_root}/${module}-${target_tag}"
    cd "${module_path}"
    git checkout "${target_tag}"
    mkdir -p "${build_path}"
    cd "${build_path}"
    ${module_path}/autogen.sh --prefix "${install_prefix}" ${config_flags[$index]}
    #there is a bug, that doc build need wayland. so we need to disable doc build
    make -j4 2>&1 | tee "make-${logfile}"
    make install 2>&1 | tee "install-${logfile}"
done
