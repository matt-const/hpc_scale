#!/bin/bash
# $File: benchmark.sh
# $Last-Modified: "2025-07-07 14:10:09"
# $Author: Matyas Constans.
# $Notice: (C) Matyas Constans 2024 - All Rights Reserved.
# $License: You may use, distribute and modify this code under the terms of the MIT license.
# $Note: Benchmark script -- launches multiple slurm jobs with different node counts
# - then computes scalability based on the results of the runs.

wall_time="01:00:00"
node_counts=(1 2 4 8 12)
slurm_script="./hpc/slurm_${1}.sh"

rm -r log_files
mkdir log_files

for index in "${node_counts[@]}"; do
    sbatch \
        --job-name=hpc_scale_bench_${index} \
        --time=${wall_time} \
        --nodes=${index} \
        --output=log_files/bench_stdout_${index}.out \
        --error=log_files/bench_stderr_${index}.out \
        $slurm_script ./build/hpc_scale
done
