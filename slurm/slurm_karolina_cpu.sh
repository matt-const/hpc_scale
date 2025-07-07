#!/bin/bash
# $File: slurm_karolina.sh
# $Last-Modified: "2025-07-07 12:09:00"
# $Author: Matyas Constans.
# $Notice: (C) Matyas Constans 2025 - All Rights Reserved.
# $License: You may use, distribute and modify this code under the terms of the MIT license.
# $Note: Karolina specific SLURM configuration values. This gets called by the main slurm file
# and only handles specific things for the Karolina architecture.

# NOTE(cmat): For CPU tasks, we run on the long 'qcpu' partition.
#SBATCH --partition=qcpu

# NOTE(cmat): We want 8 MPI processes per node.
#SBATCH --ntasks-per-node=8

# NOTE(cmat): Physical cores per mpi processes -- corresponds to one NUMA node.
#SBATCH --cpus-per-task=16

# NOTE(cmat): Specify memory usage per pysical core, in Megabytes.
# - 1900 Megabytes * 8 * 16 = 243,200 Megabytes = 237.5 Gigabytes / node.
#SBATCH --mem-per-cpu=1900M

# NOTE(cmat): Make sure we're actually using the nodes exclusively,
# - nothing else should be running while we're running.
#SBATCH --exclusive

# TODO(cmat): The validity of this claim is to be checked.
# NOTE(cmat): According to docs, it seems to be better for most
# - applications to disable hyperthreading.
#SBATCH --hint=nomultithread

# NOTE(cmat): Optmimize the distribution of MPI tasks.
#SBATCH --distribution=block:cyclic

# NOTE(cmat): Load modules.
module load OpenMPI/4.1.5-GCC-12.3
module load GCC/12.3.0
module load hwloc/2.9.1-GCCcore-12.3.0

# NOTE(cmat): Change to command submission directory.
cd $SLURM_SUBMIT_DIR

# NOTE(cmat): Disable OpenIB, apparently it doesn't play well with PMX.
export OMPI_MCA_btl=^openib

# NOTE(cmat): Launch executable with slurm + MPI.
srun --mpi=pmix --cpu-bind=cores numactl --cpunodebind=$((SLURM_LOCALID / 2)) --membind=$((SLURM_LOCAL_ID/2)) ${1}
