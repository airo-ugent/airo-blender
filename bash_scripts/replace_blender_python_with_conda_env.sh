#!/bin/bash
# Description: Change the python interpreter to a conda environment.
# Must be called from the parent directory of the blender installation.

read -p "Enter path of the conda environment you want to link to blender: " conda_env_path
# check if dir exists
if [ ! -d "$conda_env_path" ]; then
    echo "python executable does not exist at path $conda_env_path."
    exit 1
fi


blender_python_interpreter_path="$PWD/blender-3.4.1-linux-x64/3.4/python"
# check if dir exists
if [ ! -d "$blender_python_interpreter_path" ]; then
    echo "blender python folder does not exist at path $blender_python_interpreter_path, make sure to run this script from the parent folder of your blender installation."
    exit 1
fi
# check if dir is a symlink
if [! -L "$blender_python_interpreter_path"]; then
    # if it is not a symlink, rename it for backup
    echo "renaming the original blender python folder"
    mv "$blender_python_interpreter_path" "$blender_python_interpreter_path.blender"
else
    # if it is a symlink, remove it
    echo "removing a previous symlink to a conda environment"
    rm -r "$blender_python_interpreter_path"
fi

ln -s "$conda_env_path" "$blender_python_interpreter_path"



