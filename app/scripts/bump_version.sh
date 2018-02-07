#!/bin/bash

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
VERSIONCODE=`grep versionCode $GRADLE_FILE | sed 's/.*versionCode="//;s/".*//'`
VERSIONNAME=`grep versionName $GRADLE_FILE | sed 's/.*versionName="//;s/\.[0-9]*"".*//'`

# Get new number
VERSIONCODE=`echo $VERSIONCODE | sed 's/versionCode //'`
NEWVERSIONCODE=$((VERSIONCODE+1))

# Get new name
VERSIONNAME=`echo $VERSIONNAME | sed 's/versionName //' | sed 's/"//g'`
NEWVERSIONNAME="$(./shell_semver.sh "$@" $VERSIONNAME)"

echo "Old Version Code: $VERSIONCODE"
echo "New Version Code: $NEWVERSIONCODE"
echo "Old Version Name: $VERSIONNAME"
echo "New Version Name: $NEWVERSIONNAME"

sed -i 's/\(versionCode\) [0-9]*/\1 '$NEWVERSIONCODE'/; s/\(versionName\) \"[0-9.]*\"/\1 '$NEWVERSIONNAME'/' $GRADLE_FILE
