#!bin/bash

# Description: Add the blender executable to the path
# must be called from the parent directory of the blender installation

# check if blender is installed
if [ ! -d "blender-3.4.1-linux-x64" ]; then
    echo "blender is not installed in the current directory"
    exit 1
fi
export PATH="$PWD/blender-3.4.1-linux-x64:$PATH"
