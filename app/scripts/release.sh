#!/bin/bash

# if any command fails at any point, quit
set -e

display_usage() { 
    echo "Usage $(basename $0) [-Mmp] major.minor.patch"
	} 

# ./bump_version.sh   
if [[ "$1" == "--help" || "$1" == "-h" || $# -eq 0  ]]; then
    display_usage
    exit 1
fi

# Check working directory and exit if bad
DIR="$(basename $(pwd) )"
if [ $DIR != 'scripts' ] && [ $DIR == 'app' ]; then
    cd ./scripts
elif [ $DIR != 'scripts' ]; then
    echo "In /$DIR"
    echo "This must be run from inside the /scripts directory"
    exit 1
fi

./bump_version.sh  "$@"
./build_db_and_assets.sh
