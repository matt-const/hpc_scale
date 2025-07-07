# $File: build.sh
# $Last-Modified: "2025-07-07 15:01:40"
# $Author: Matyas Constans.
# $Notice: (C) Matyas Constans 2024 - All Rights Reserved.
# $License: You may use, distribute and modify this code under the terms of the MIT license.
# $Note: Build script.

# NOTE(cmat): Load appropriate modules.
. ./hpc_config/module_"${1}".sh

mkdir -p build
pushd build > /dev/null

compiler="-O3 -pthread"
linker="-o hpc_scale -lnuma"
source="../src/hs_entry.c"

mpicc $compiler $source $linker

popd > /dev/null
