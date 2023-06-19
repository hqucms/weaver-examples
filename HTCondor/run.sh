#!/bin/bash

inputdir=/eos/user/h/hqu/www/datasets/JetClass/example

# path to miniconda3 installation
condadir=

# path to the data config yaml and network config python file
# the example here uses this repo: https://github.com/jet-universe/particle_transformer
workdir=

# path to store the output model
modeldir=

# suffix for the job
suffix=

# activate miniconda environment
. "${condadir}/etc/profile.d/conda.sh"
conda activate weaver

nvcc --version
nvidia-smi

# this is needed: setting `TMPDIR` to be the scratch area of the condor job
export TMPDIR=$(pwd)
set -x

model=ParT
weaver \
    --data-train "${inputdir}/JetClass_example_100k.root" --copy-inputs \
    --data-config ${workdir}/data/JetClass/JetClass_full.yaml \
    --network-config ${workdir}/networks/example_ParticleTransformer.py --use-amp \
    --model-prefix ${modeldir}/training/JetClass/${model}/{auto}${suffix}/net \
    --num-workers 1 --fetch-step 0.5 \
    --batch-size 512 --start-lr 1e-3 --optimizer ranger --num-epochs 20 --gpus 0 \
    --log logs/JetClass_${model}_{auto}${suffix}.log
