#!/bin/bash

usage() {
        echo "Usage:";
        echo "$0 <recette|production>";
}

#Test si 1 paramètre est fourni à l'execution
if [ $# -lt 1 ];
then
        usage;
        exit 1;
fi

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

./.execute.sh deploy $NAME
