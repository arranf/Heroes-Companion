find assets/ -type f > ls.txt
sed -i -e 's/^/- /' ls.txt 
