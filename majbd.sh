#!/bin/bash

usage() {
	echo "Usage:";
	echo "$0 <recette|production>";
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

./.execute.sh majbd $NAME

