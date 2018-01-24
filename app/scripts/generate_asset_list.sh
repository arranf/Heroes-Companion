find ../assets/ -type f -name "*.png" > ls.txt
# Replace the start of a line ../ with four spaces and a -
sed -i -e 's/^..\//    - /' ls.txt 
