![Synthetic data generation box keypoints example](https://i.imgur.com/ZpH0grX.jpg)

# airo-blender

A Python package on top of the [Blender Python API](https://docs.blender.org/api/current/index.html) to
generate synthetic data for robotic manipulation.

To get started, please see the [tutorials](docs/tutorials) directory after completing the installation. :notebook_with_decorative_cover:


## Installation

Clone this repo somewhere or add it as a submodule to your project. The airo-blender package depends on the airo-mono repo, which is added as a submodule in this repo for convenience. If you will use the airo-mono repo yourself, you should probably add it as a submodule to your repo yourself. If not, you can recursively clone this repo to already have a local clone of the mono repo as well.

To use this package you need at least a local installation of Blender. You can install this anywhere on your pc.
Blender ships with its own python interpreter but we recommend replacing it with a conda environment to have an easier workflow.

We provide a convenience script that will do both the above for you, if you want to use this, run the following commands:
```bash
bash <path-to-airo-blender>/bash_scripts/setup_blender <<< <path-to-your-conda-env> 
```

If you don't have a conda environment already, you can take inspiration from the `environment.yaml` file that is included in this repo.
Make sure to update the paths of the airo-blender package and possibly of the airo-mono paths if you made it a top-level submodule.

Make sure to create your conda environment with.
``` conda env create -f environment.yaml```
You can now use the path to this conda env in the bash script to install blender and link this conda env.

#TODO: the above is probably completely unreadable, has to be improved...

## Philosophy
This package is meant to be as lightweight and opt-in as possible.
We deliberately stick close to the Blender API and keep data explicit.
This means that we for example don't wrap the Blender datatypes with custom Python classes.

Alternatives to this library are:
* [BlenderProc](https://github.com/DLR-RM/BlenderProc)
* [kubric](https://github.com/google-research/kubric)

### Why don't we use the alternatives?
Both libraries provide a lot of great functionality.
However, we choose not to use them because they introduce **too many new concepts** on top of Blender.

For example, to make a light in Kubric (from [helloworld.py](https://github.com/google-research/kubric/blob/main/examples/helloworld.py)), you do:
```python
scene += kb.DirectionalLight(name="sun", position=(-1, -0.5, 3), look_at=(0, 0, 0), intensity=1.5)
```
In blenderproc (from [basic/main.py](https://github.com/DLR-RM/BlenderProc/blob/main/examples/basics/basic/main.py)) you would do:
```python
light = bproc.types.Light()
light.set_type("POINT")
light.set_location([5, -5, 5])
light.set_energy(1000)
```
However, this use case can be handled perfectly fine by the Blender Python API itself e.g:
```python
bpy.ops.object.light_add(type='POINT', radius=1, location=(0, 0, 0))
```
Introducing these additional abstractions on top of Blender creates uncertainty.
Where does the light data live and how does it sync with the Blender scene? Am I still allowed to edit the Blender scene directly, or do I have to do it the "Kubric/Blenderproc way"?
Kubric and Blenderproc both push a very specific workflow.
They try hard to hide/replace Blender, instead of extending it.
As a consequence, these libraries feel very much **"all or nothing"**.
By hiding what is going on, these libraries make it harder to experiment and add new features.

In airo-blender, we prefer explaining the Blender Python API over hiding it.
In the tutorials we show our workflow and the functions we use.
We try to operate on the Blender data as statelessly as possible, with simple functions.
As a result you can easily adopt only the parts you like.

### Why is airo-blender not part of airo-mono? 
Blender requires a specific python version for each release. 
Not all python version have a blender version and we did not feel like locking the python version of our mono repo to please blender, so we decided to make it a standalone repo that depends on the airo-mono repo.