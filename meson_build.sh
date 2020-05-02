#!/usr/bin/env bash
set -e

function join_by { local d=$1; shift; echo -n "$1"; shift; printf "%s" "${@/#/$d}"; }

./gst_check_env.sh

target_tag="$1"
echo "target tag/branch=${target_tag}"

run_config="$2"
setup_opts="$3"



datestr="$(date +"%Y%m%d-%H%M%S")"
logfile="${datestr}.log"
build_root="${GST_BUILD_ROOT}"
src_root="${GST_SRC_ROOT}"
install_prefix="${GST_INSTALL_PATH}"

module="gst-build"
module_path="${src_root}/${module}"
build_path="${build_root}/${module}-${target_tag}"
cd "${module_path}"

git checkout "${target_tag}"
if [ ! -d ${build_path} ]
then
    mkdir -p "${build_path}"
fi

meson_flags_ar=(
    "-Dgstreamer:bash-completion=disabled" # the bash completion cause install problem when bash-completion =2.9
    "-Dgstreamer:libunwind=enabled"
    "-Dgstreamer:libdw=enabled"
    "-Dgstreamer:coretracers=enabled"
    "-Dbase:pango=enabled" # for drawing overlay
    "-Dgood=enabled"
    "-Dugly=enabled"
    "-Dbad=enabled"
    "-Dlibav=enabled"
    "-Drtsp_server=enabled"
    "-Dges=disabled"
    "-Domx=disabled"
    "-Drs=disabled"
    "-Dgtk_doc=disabled"
)
meson_opts="$(join_by " " "${meson_flags_ar[@]}")"
echo "meson_opts=${meson_opts}"
meson_conf_log="${build_path}/meson-config-${logfile}"
ninja_log="${build_path}/ninja-${logfile}"

# setup_opts=""
if [ -f "${build_path}/build.ninja" ]
then
#     setup_opts="--reconfigure"
    echo "has build.ninja, and run_config=${run_config}"
else
    run_config="yes"
fi
if [ ${run_config} = yes ]
then
# strangly meson won't exit with errcode, even if it fails the setup
    meson setup ${setup_opts} \
        --prefix "${install_prefix}" \
        ${meson_opts} \
        "${build_path}" 2>&1 \
        | tee "${meson_conf_log}"

    echo "Config Done!"
fi
ninja -v -C "${build_path}"
meson install -C "${build_path}"
