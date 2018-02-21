# Check working directory and exit if bad
DIR="$(basename $(pwd) )"
if [ $DIR != 'scripts' ]; then
    echo "In /$DIR"
    echo "This must be run from inside the /scripts directory"
    exit 1
fi

APP_DIR="$(dirname "$PWD")"
DATA_DIR=~/projects/hots-json-to-sqlite
ASSETS_DIR=$APP_DIR/assets
mkdir -p  $APP_DIR/assets/images

# Get latest version of db and images
cd $DATA_DIR && ./run.sh

# TODO if images doesn't exist, make it

# Copy assets over
cp $DATA_DIR/upload/heroes_companion.db $ASSETS_DIR
cp -r $DATA_DIR/heroes-talents/images/* $ASSETS_DIR/images

# Replace delimeted part of pubspec.yaml assets section with list of assets 
sed '/# START IMAGES HERE/,/# END IMAGES HERE/{//!d}' $APP_DIR/pubspec.yaml > $APP_DIR/pubspec.temp.yaml
cd $APP_DIR/scripts && ./generate_asset_list.sh 
mv $APP_DIR/pubspec.temp.yaml $APP_DIR/pubspec.yaml
sed '/# START IMAGES HERE/r ls.txt' $APP_DIR/pubspec.yaml > $APP_DIR/pubspec.temp.yaml
mv $APP_DIR/pubspec.temp.yaml $APP_DIR/pubspec.yaml
rm ./ls.txt