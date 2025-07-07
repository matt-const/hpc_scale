# HPC Scale

This project contains a series of samples using MPI + pthreads (hybrid MPI),
for testing scaling on HPC architectures at very large node and core numbers.

## Build instructions
Make sure you have a C99 complient compiler available — then call the build script with either `debug` or `release`:

`./build.sh release`

## HPC Specific scripts
Different HPC architectures have different configurations.
We currenly provide scripts for the following HPC architectures.

- [Karolina](https://www.it4i.cz/en/infrastructure/karolina)
