#!/bin/bash

# if any command fails at any point, quit
set -e

#https://stackoverflow.com/questions/29436275/how-to-prompt-for-yes-or-no-in-bash
function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return 1 ;;
        esac
    done
}

# Check working directory and exit if bad
DIR="$(basename $(pwd) )"
if [ $DIR != 'scripts' ]; then
    echo "In /$DIR"
    echo "This must be run from inside the /scripts directory"
    exit 1
fi

# echo "Old Version: $CURRENT_VERSION"
# NEWNAME="$(./shell_semver.sh "$@" $CURRENT_VERSION)"
# echo "New Version: $NEWNAME"

APP_DIR="$(dirname "$PWD")"
ANDROID_DIR=$APP_DIR/android/app/

GRADLE_FILE=$ANDROID_DIR"build.gradle"
# https://gist.github.com/kendellfab/3111850
# TODO Actually get these parsed correctly first time
VERSIONCODE=`grep versionCode $GRADLE_FILE | sed 's/.*versionCode="//;s/".*//'`
VERSIONNAME=`grep versionName $GRADLE_FILE | sed 's/.*versionName="//;s/\.[0-9]*"".*//'`

# Get new number
VERSIONCODE=`echo $VERSIONCODE | sed 's/versionCode //'`
NEWVERSIONCODE=$((VERSIONCODE+1))

# Get new name
VERSIONNAME=`echo $VERSIONNAME | sed 's/versionName //' | sed 's/"//g'`
NEWVERSIONNAME="$(./shell_semver.sh "$@" $VERSIONNAME)"

echo "Old Version: $VERSIONNAME"
echo "New Version: $NEWVERSIONNAME"

message="Do you want to write the new version?"
yes_or_no "$message" && sed -i 's/\(versionCode\) [0-9]*/\1 '$NEWVERSIONCODE'/; s/\(versionName\) \"[0-9.]*\"/\1 '\"$NEWVERSIONNAME\"'/' $GRADLE_FILE