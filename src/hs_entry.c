// $File: hpc_scale.c
// $Last-Modified: "2025-07-08 12:40:07"
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
  int cores_per_numa_node = 0;

  if (numa_available() >= 0) {
    numa_node_count     = numa_max_node() + 1;
    physical_core_count = numa_num_configured_cpus();
    cores_per_numa_node = physical_core_count / numa_node_count;
  } else {
    numa_node_count     = -1;
    physical_core_count = -1;
    cores_per_numa_node = -1;
  }

  int tasks_per_node = -1;
  char *env_tasks_per_node = getenv("MPI_PER_NODE");
  if (env_tasks_per_node) {
    tasks_per_node = atoi(env_tasks_per_node);
  }

  int local_node_rank       = mpi_rank % tasks_per_node;
  int local_node_numa_index = local_node_rank % numa_node_count;
  int base_core_index       = local_node_numa_index * cores_per_numa_node;

  // NOTE(cmat): Log all info.
  // #--
  fprintf(stdout,
          "Rank :: %d\n"
          "  Physical Core Count    :: %d\n"
          "  NUMA Node Count        :: %d\n"
          "  Core Count / NUMA Node :: %d\n"
          "  MPI process / Node     :: %d\n"
          "  Local Node Rank        :: %d\n"
          "  Local Node NUMA Rank   :: %d\n"
          "  Base Thread Core Index :: %d\n",

          mpi_rank,
          physical_core_count,
          numa_node_count,
          cores_per_numa_node,
          tasks_per_node,
          local_node_rank,
          local_node_numa_index,
          base_core_index
          );

  MPI_Finalize();
}

