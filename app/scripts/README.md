# A Quick Primer

## generate\_asset\_list.sh
This generates a list of the assets in the `assets/images/` folder and updats the `pubspec.yaml` to match. It requires a GNU version of sed, not the BSD version shipped with OSX. You can switch your version with `brew install gnu-sed --with-default-names`.

## build\_db\_and_assets.sh
Requires a dir `~/projects/hots-json-to-sqlite` containing [this repository](https://github.com/arranf/hots-json-to-sqlite). The repository is a set of scripts to build a sqlite database from a set of data files for each hero. The script pulls the latest version of the data files, builds a fresh database, copies over the images, and updates the pubspec.yaml.

## bump\_version.sh and shell\_semver.sh
Used to bump the Android version in `build.gradle` in a semver-esque style. 

## release.sh
This script is a wrapper script that combines all the scripts above. I use it to bump the Android version and then get the latest version of the database and assets.