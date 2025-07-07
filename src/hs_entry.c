// $File: hpc_scale.c
// $Last-Modified: "2025-07-07 16:37:34"
// $Author: Matyas Constans.
// $Notice: (C) Matyas Constans 2024 - All Rights Reserved.
// $License: You may use, distribute and modify this code under the terms of the MIT license.
// $Note: Entry point defined here.

#include <stdint.h>
#include <pthread.h>
#include <mpi.h>
#include <numa.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv) {
  
  // NOTE(cmat): Initialize MPI.
  // #--
  int mpi_thread_support = 0;
  MPI_Init_thread(&argc, &argv, MPI_THREAD_MULTIPLE, &mpi_thread_support);

  int mpi_rank = 0;
  int mpi_size = 0;
  MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

  // NOTE(cmat): Get information about NUMA nodes. (Non-Uniform Memory Access).
  // #--
  int numa_node_count     = 0;
  int physical_core_count = 0;
  int thread_count        = 0;

  if (numa_available() >= 0) {
    numa_node_count     = numa_max_node() + 1;
    physical_core_count = numa_num_configured_cpus();
    thread_count = physical_core_count / numa_node_count;
  }

  // NOTE(cmat): Log all this information
  // #--
  char *job_name = getenv("SLURM_JOB_NAME"); 
  FILE *out = fopen(job_name, "a");

  char buffer[512];
  snprintf(buffer, 512, "Rank :: %d, Size :: %d, NUMA Node Count :: %d, Physical Core Count :: %d, :: Thread Count :: %d\n",
           mpi_rank, mpi_size, numa_node_count, physical_core_count, thread_count);

  fwrite(buffer, strlen(buffer), 1, out);
  fclose(out);
  
  MPI_Finalize();
}
