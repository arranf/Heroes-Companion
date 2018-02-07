# Check working directory and exit if bad
DIR="$(basename $(pwd) )"
if [ $DIR != 'scripts' ]; then
    echo "In /$DIR"
    echo "This must be run from inside the /scripts directory"
    exit 1
fi

find ../assets/ -type f -name "*.png" > ls.txt
# Replace the start of a line ../ with four spaces and a -
sed -i -e 's/^..\//    - /' ls.txt 
