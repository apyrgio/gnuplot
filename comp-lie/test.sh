#! /bin/bash

export FORCE_WCP="writeback"
export FORCE_CACHE_OBJECTS="8"
export FORCE_CACHE_SIZE_AMPLIFY="1x"
export FORCE_IODEPTH="4 8 12 16"
export FORCE_THREADS="multi"
export FORCE_BENCH_OBJECTS="bounded"
export FORCE_BENCH_SIZE_AMPLIFY="1x"
export FORCE_USE_CACHED="no"

rm ~/sosd/*
rm ~/cached/*

for bs in 4k 8k 16k 32k 64k; do
	export FORCE_BLOCK_SIZE=$bs
	~/scripts/stress_cached.sh -l ~/log -r ~/sosd -w -y -v 1
done

export FORCE_CACHE_OBJECTS=256
export FORCE_USE_CACHED="yes"

for bs in 4k 8k 16k 32k 64k; do
	export FORCE_BLOCK_SIZE=$bs
	~/scripts/stress_cached.sh -l ~/log -r ~/cached -w -y -v 1
	export FORCE_CACHE_OBJECTS=$(( $FORCE_CACHE_OBJECTS * 2 ))
done
