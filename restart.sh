#!/bin/bash

usage() {
	echo "Usage:";
	echo "$0 <recette|production> [--from-scratch]";
}

NAME=$1;

case $NAME in
	recette)
	;;
	production)
	;;
	*)
		usage;
		exit 1;
	;;
esac

./.execute.sh restart $NAME $2

