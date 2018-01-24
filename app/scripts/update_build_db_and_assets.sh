DATA_DIR=~/projects/hero_data_to_sql
APP_DIR="$(dirname "$PWD")"
ASSETS_DIR=$APP_DIR/assets

# Get latest version of db and images
cd $DATA_DIR && ./run.sh

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