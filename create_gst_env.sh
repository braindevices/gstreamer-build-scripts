#!/usr/bin/env bash
set -e

./gst_check_env.sh

gst_env_path="${GST_INSTALL_PATH}/bin/gst_env"
py3_site="$(python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"].lstrip("/usr"))')"

echo "export LD_LIBRARY_PATH=\"${GST_INSTALL_PATH}/${LIB_DIR}:\${LD_LIBRARY_PATH}\"" > ${gst_env_path}
echo "export PATH=\"${GST_INSTALL_PATH}/bin:\$PATH\""  >> ${gst_env_path}
echo "export PYTHONPATH=\"${GST_INSTALL_PATH}/${py3_site}:\$PYTHONPATH\"" >> ${gst_env_path}
echo "export GST_PLUGIN_SCANNER=\"${GST_INSTALL_PATH}/libexec/gstreamer-1.0/gst-plugin-scanner\"" >> ${gst_env_path}
echo "before run any gst command use 'source ${gst_env_path}'"
