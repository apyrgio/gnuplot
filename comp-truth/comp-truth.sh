#! /bin/bash

export FORCE_WCP="writeback"
#export FORCE_CACHE_OBJECTS="cs*8"
export FORCE_CACHE_SIZE="bs/64 bs/32 bs/16 bs/8"
export FORCE_IODEPTH="16"
export FORCE_THREADS="multi"
export FORCE_BENCH_OBJECTS="bounded"
export FORCE_BENCH_SIZE="2G"
export FORCE_BLOCK_SIZE="4k"
export FORCE_USE_CACHED="no"

rm ~/sosd/*
rm ~/cached/*

#for bs in 4k 8k 16k 32k 64k; do
#	export FORCE_BLOCK_SIZE=$bs
#	~/scripts/stress_cached.sh -l ~/log -r ~/sosd \
#		-prog no -y -w -v 1
#done

export FORCE_USE_CACHED="yes"

I=0
for co in cs*1 cs*2 cs*4 cs*8; do
	I=$(( $I+1 ))
	export FORCE_CACHE_OBJECTS=$co
	~/scripts/stress_cached.sh -l ~/log -r ~/cached \
		-prog no -rtype io,lat -rpost $I -y -w -v 1
done
