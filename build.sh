# $File: build.sh
# $Last-Modified: "2025-07-07 15:01:40"
# $Author: Matyas Constans.
# $Notice: (C) Matyas Constans 2024 - All Rights Reserved.
# $License: You may use, distribute and modify this code under the terms of the MIT license.
# $Note: Build script.

mkdir -p build
pushd build > /dev/null

compiler="-O3 -pthread -I{$HWLOC_ROOT}/include"
linker="-o hpc_scale -L{$HWLOC_ROOT}/lib -lhwloc"
source="../src/hpc_scale.c"

mpicc $compiler $source $linker

popd build > /dev/null
