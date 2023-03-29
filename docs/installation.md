# Installation

You can find the **Quick Installation** in the main README.md file of this repository.
This file contains additional information about the installation process e.g. for custom installations.

## Installation with Conda environment
Clone this repo somewhere or add it as a submodule to your project:

The airo-blender package depends on the airo-mono repo, which is added as a submodule in this repo for convenience. If you will use the airo-mono repo yourself, you should probably add it as a submodule to your repo yourself. If not, you can recursively clone this repo to already have a local clone of the mono repo as well. Run:
```
git submodule init
git submodule update --recursive
```

To use this package you need at least a local installation of Blender. You can install this anywhere on your pc, but we recommend the `blender/` folder in this folder.

Blender ships with its own python interpreter but we recommend replacing it with a conda environment to have an easier workflow.

We provide a convenience script that will do both the above for you, if you want to use this, run the following commands:
```bash
bash <path-to-airo-blender>/bash_scripts/setup_blender <<< <path-to-your-conda-env>
```

If you don't have a conda environment already, you can take inspiration from the `environment.yaml` file that is included in this repo.
Make sure to update the paths of the airo-blender package and possibly of the airo-mono paths if you made it a top-level submodule.

Make sure to create your conda environment with.
```conda env create -f environment.yaml```
You can now use the path to this conda env in the bash script to install blender and link this conda env.

Additionally, you can run`source bash_scripts/add_blender_to_path.sh` script from the parent directory of your blender installation, to add the blender executable to the path of your terminal.
