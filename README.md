![Synthetic data generation box keypoints example](https://i.imgur.com/ZpH0grX.jpg)

# airo-blender

A Python package on top of the [Blender Python API](https://docs.blender.org/api/current/index.html) to
generate synthetic data for robotic manipulation.

To get started, please see the [tutorials](docs/tutorials) directory after completing the installation. :notebook_with_decorative_cover:

## Quick Installation

This installation method requires **Anaconda** to be installed on your system.
We will replace the Python environment Blender ships with, with a new Conda environment.
This makes it more convenient to install additional Python packages later.

Clone this repo with submodules:

```
git clone --recurse-submodules git@github.com:airo-ugent/airo-blender.git
```

Create the `airo-blender` conda environment:

```
cd airo-blender
conda env create -f environment.yaml
```

Find the path to the `airo-blender` conda environment:

```
conda env list
```

The path to your conda environment should be something like:

```bash
/home/<username>/anaconda3/envs/airo-blender
```

Run the following script to download Blender 3.4.1 and to replace its Python environment with the `airo-blender` conda environment, be sure to replace the path to your conda environment:

```bash
cd blender
bash ../bash_scripts/setup_blender <<< <path-to-your-conda-env>
```

Finally, to have the `blender` command available in your terminal, you need to add its directory to `PATH`, to temporarily add it (only for the current terminal), run:

```bash
export PATH="$PATH:$PWD/blender-3.4.1-linux-x64"
```



To test your installation, you can run the script of the first tutorial:
```
blender -P ../docs/tutorials/01_the_python_api/tutorial_1.py
```

To add the `blender` command permanently, read [adding_blender_to_bashrc.md](docs/adding_blender_to_bashrc.md)

## Philosophy

This package is meant to be as lightweight and opt-in as possible.
We deliberately stick close to the Blender API and keep data explicit.
This means that we for example don't wrap the Blender datatypes with custom Python classes.

Alternatives to this library are:

- [BlenderProc](https://github.com/DLR-RM/BlenderProc)
- [kubric](https://github.com/google-research/kubric)

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

### Why the complicated Conda python stuff?

We want to make it convenient to work with scripting for blender. Most developers are used to have a virtualenv/conda env that they can work in, install dependencies in etc. Having to always specify the blender python interpreter is a hassle and the blender python version is not complete so you need to do some additional steps (download c headers etc).

Blender [proposes](https://docs.blender.org/api/current/info_tips_and_tricks.html#bundled-python-extensions) to build blender manually with a conda env link instead, but building takes about 30m, so this approach of replacing the python folder in the blender directory inspired by this [post](https://stackoverflow.com/questions/70639689/how-to-use-the-anaconda-environment-on-blender) seemed more convenient. A downside however is that
