#!/usr/bin/env bash
set -e
var_names="GST_SRC_ROOT GST_BUILD_ROOT GST_REPO_NAMES GST_INSTALL_PATH"
for var in ${var_names}
do
    if [ -z "${!var}" ]
    then
        echo "${var} has not been set in ENV" > /dev/stderr
        exit 1
    fi
done
