#! /bin/bash

export FORCE_WCP="writeback"
export FORCE_CACHE_OBJECTS="bs"
export FORCE_CACHE_SIZE="bs*2"
export FORCE_IODEPTH="4 8 12 16"
export FORCE_THREADS="4"
export FORCE_BENCH_OBJECTS="bounded"
export FORCE_BENCH_SIZE="64M"
export FORCE_BLOCK_SIZE="4k"
export FORCE_USE_CACHED="no"

rm ~/sosd/*
rm ~/cached3/*

if [[ 1 -eq 0 ]]; then
for bs in 4k 8k 16k 32k 64k; do
	export FORCE_BLOCK_SIZE=$bs
	~/scripts/stress_cached.sh -l ~/log -r ~/sosd \
		-prog no -rtype io -w -verify no $@
done
fi

export FORCE_BENCH_SIZE="16G"
export FORCE_USE_CACHED="yes"

for bs in 4k 8k 16k 32k 64k; do
	export FORCE_BLOCK_SIZE=$bs
	~/scripts/stress_cached.sh -l ~/log -r ~/cached3 \
		-prog no -rtype io,lat -w -verify no $@
done
