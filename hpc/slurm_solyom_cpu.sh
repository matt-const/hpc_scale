#!/bin/bash
# $File: slurm_karolina.sh
# $Last-Modified: "2025-07-07 12:09:00"
# $Author: Matyas Constans.
# $Notice: (C) Matyas Constans 2025 - All Rights Reserved.
# $License: You may use, distribute and modify this code under the terms of the MIT license.
# $Note: Solyom specific SLURM configuration values. This gets called by the main slurm file
# and only handles specific things for SZE's (Szechenyi Istvan University, Hungary),
# our university's cluster.

# NOTE(cmat): For CPU tasks, we run on the long 'qcpu' partition.
#SBATCH --partition=compute

# NOTE(cmat): We want 8 MPI processes per node.
#SBATCH --ntasks-per-node=2

# NOTE(cmat): Physical cores per mpi processes -- corresponds to one NUMA node.
#SBATCH --cpus-per-task=16

# NOTE(cmat): Make sure we're actually using the nodes exclusively,
# - nothing else should be running while we're running.
#SBATCH --exclusive

# NOTE(cmat): Optmimize the distribution of MPI tasks.
#SBATCH --distribution=block:cyclic

# NOTE(cmat): Load modules.
. ./hpc_config/module_solyom_cpu.sh

# NOTE(cmat): Change to command submission directory.
cd $SLURM_SUBMIT_DIR

# NOTE(cmat): Disable OpenIB, apparently it doesn't play well with PMX.
export OMPI_MCA_btl=^openib

# NOTE(cmat): Launch executable with slurm + MPI.
export MPI_PER_NODE=8
srun --mpi=pmix --cpu-bind=cores numactl --cpunodebind=$((SLURM_LOCALID / 2)) --membind=$((SLURM_LOCAL_ID/2)) ${1}
