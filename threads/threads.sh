#! /bin/bash

export FORCE_WCP="writeback"
export FORCE_CACHE_OBJECTS="cs*1"
export FORCE_CACHE_SIZE="bs*2"
export FORCE_IODEPTH="1 2 4 8 16"
export FORCE_THREADS="1"
export FORCE_BENCH_OBJECTS="bounded"
export FORCE_BENCH_SIZE="8G"
export FORCE_BLOCK_SIZE="4k"
export FORCE_USE_CACHED="yes"

rm ~/threads/*
rm ~/threads-lat/*

I=0
for threads in 1 2 3 4 5 8 16; do
	I=$(( $I+1 ))
	export FORCE_THREADS=$threads
	~/scripts/stress_cached.sh -l ~/log -r ~/threads \
		-prog no -rtype io,lat -rpost $I -w -y -v 1
done
