#! /bin/bash

export FORCE_WCP="writeback"
export FORCE_CACHE_OBJECTS="cs*1"
export FORCE_CACHE_SIZE="bs*2"
export FORCE_IODEPTH="16"
export FORCE_THREADS="2"
export FORCE_BENCH_OBJECTS="bounded"
export FORCE_BENCH_SIZE="4G"
export FORCE_BLOCK_SIZE="4k"
export FORCE_USE_CACHED="yes"

rm ~/cold/*

~/scripts/stress_cached.sh -l ~/log -r ~/cold \
	-prog no -rtype io,lat -w -y -v 1
