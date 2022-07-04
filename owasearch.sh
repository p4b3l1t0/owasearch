#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

domlist=$1
entries=$(wc -l < $1)
echo "File contains" $entries "domains"
for i in $(seq 1 $entries); do
        line=$(sed "${i}q;d" $domlist)
        echo -ne $i/$entries "\r"
        curl -s -I --max-time 5 -sk https://$line/owa/auth/logon.aspx  | if grep -q "200 OK"; then echo $line"         --->>>  it has Outlook Web App"; fi >> results.txt
done
cat results.txt | uniq | sort -u
echo -e "${RED}Results were saved in results.txt file${NC}"
#Checking if there is an argument
if [[ -z $1 ]]; then
        echo "Please specify a Domain: ./owasearch <file_with_domains>"
        exit
fi
