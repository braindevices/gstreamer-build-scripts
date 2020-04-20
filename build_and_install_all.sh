#!/usr/bin/env bash
set -e
target_tag="$1"
only_gstreamer="$2"
datestr="$(date +"%Y%m%d-%H%M%S")"
logfile="${datestr}.log"
build_root="${HOME}/Projects/gstreamer/builds"
src_root="${HOME}/Projects/gstreamer"
install_prefix="${HOME}/opt/gstreamer-all"

export PKG_CONFIG_PATH="${install_prefix}/lib/pkgconfig:${PKG_CONFIG_PATH}"
echo "target tag/branch=${target_tag}"
if [ ${only_gstreamer} = "yes" ]
then
    modules=(
        gstreamer
    )
    config_flags=("")
else
    modules=(
        gst-plugins-base
        gst-plugins-good
        gst-plugins-ugly
        gst-plugins-bad
        gst-libav
        gst-rtsp-server
    )
    config_flags=(
        "--enable-pango --disable-wayland --disable-gtk-doc"
        ""
        ""
        "--enable-pango"
        ""
        ""
    )
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
