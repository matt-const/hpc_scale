# HPC Scale

This project contains a series of samples using MPI + pthreads (hybrid MPI),
for testing scaling on HPC architectures at very large node and core numbers.

## Build Instructions
Make sure you have a C99 complient compiler available — then call the build script for your architecture of choice.

For instance, for Karolina CPU: `./build.sh karolina_cpu`

## Benchmarking Instructions
For benchmarking, make sure you've built the project first — then in a similar way, call the benchmark script for
your architecture of choice.

For instance, for Karolina CPU: `./benchmark.sh karolina_cpu`

## Supported HPC Architectures
We provided different configuration files for some HPC architectures — these all reside in `slurm/*`

We currenly provide scripts for the following HPC architectures:

- [Karolina](https://www.it4i.cz/en/infrastructure/karolina)
