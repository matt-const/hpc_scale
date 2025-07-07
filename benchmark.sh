#!/bin/bash
# $File: benchmark.sh
# $Last-Modified: "2025-07-07 14:10:09"
# $Author: Matyas Constans.
# $Notice: (C) Matyas Constans 2024 - All Rights Reserved.
# $License: You may use, distribute and modify this code under the terms of the MIT license.
# $Note: Benchmark script -- launches multiple slurm jobs with different node counts
# - then computes scalability based on the results of the runs.

wall_time="01:00:00"
node_counts=(1 2 4)

slurm_script=$1
slurm_executable=$2

for index in "${node_counts[@]}"; do
    sbatch \
        --job-name=hpc_scale_bench_${index} \
        --time=${wall_time} \
        --nodes=${index} \
        --output=bench_stdout_${n}.out \
        --output=bench_stderr_${n}.err \
        ./hpc_config/slurm_karolina_cpu.sh ./build/hpc_scale
done
