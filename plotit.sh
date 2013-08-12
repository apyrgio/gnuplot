#! /bin/bash

#Include helper scripts
source init.sh

##################
# Read arguments #
##################

MAKE="no"

while [[ -n $1 ]]; do
	if [[ $1 = '-d' ]] || [[ $1 = '--directory' ]]; then
		shift
		DIR=$1
	elif [[ $1 = '-m' ]] || [[ $1 = '--make' ]]; then
		MAKE="yes"
		shift
		DIR=$1
	elif [[ $1 = '-h' ]] || [[ $1 = '--help' ]]; then
		usage
		exit
	else
		usage
		red_echo "${1}: Unknown option. Aborting..."
		exit
	fi
	shift
done

if [[ -z $DIR ]]; then
	red_echo "No directory given. Aborting..."
	exit
fi

##################
# Make directory #
##################

if [[ $MAKE == "yes" ]]; then
	mkdir -p $DIR/data/cached
	mkdir -p $DIR/data/sosd
	exit
fi

#################
# Start ploting #
#################

cd $DIR

if [[ ! -e "plot.gpi" ]]; then
	red_echo "No plot.gpi is available"
	exit
fi

gnuplot plot.gpi
