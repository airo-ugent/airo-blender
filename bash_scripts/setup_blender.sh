#!/bin/sh
# Description: Download and extract Blender to the current directory
# and replace the python interpreter with a conda environment
# Must be called from the parent directory of the blender installation.

read -p "Enter path of python executable you want to link to blender: " conda_env_path
# check if path exists
if [ ! -d "$conda_env_path" ]; then
    echo "python executable does not exist at path $conda_env_path."
    exit 1
fi

wget https://download.blender.org/release/Blender3.4/blender-3.4.1-linux-x64.tar.xz
tar -xvf blender-3.4.1-linux-x64.tar.xz
echo "Blender has been extracted to the current directory"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/replace_blender_python_with_conda_env.sh" <<< "$conda_env_path"