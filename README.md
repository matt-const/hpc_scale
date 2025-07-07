# HPC Scale

This project contains a series of samples using MPI + pthreads (hybrid MPI),
for testing scaling on HPC architectures at very large node and core numbers.

## Build instructions
Make sure you have a C99 complient compiler available — then call the build script with either `debug` or `release`.

`./build.sh debug`
or 
`./build.sh release`

## Architecture specific scripts
We provided different configuration files for some HPC architectures — these all reside in `slurm/*`

We currenly provide scripts for the following HPC architectures:

- [Karolina](https://www.it4i.cz/en/infrastructure/karolina)
