#!/usr/bin/env bash

#
# This is a super simple way to check for domain name availablility. Here's how it works:
#
#     - Run the script bash domain-finder.sh
#     - Enter your name
#     - Enter the filename containing domain names to check (one per line)
#     - Enter the path to save results
#
# The script will use whois and grep for the string "No match for" and output the data as a pipe
# delimited file thet displays domain name, availability, and the name of the person that came up
# with the domain name.
#
# Awesome ascii cat courtesy of http://user.xmission.com/~emailbox/ascii_cats.htm
#
#              .__....._             _.....__,
#                 .": o :':         ;': o :".
#                 `. `-' .'.       .'. `-' .'
#                   `---'             `---'
#
#         _...----...      ...   ...      ...----..._
#      .-'__..-""'----    `.  `"`  .'    ----'""-..__`-.
#     '.-'   _.--"""'       `-._.-'       '"""--._   `-.`
#     '  .-"'                  :                  `"-.  `
#       '   `.              _.'"'._              .'   `
#             `.       ,.-'"       "'-.,       .'
#               `.                           .'
#          jgs    `-._                   _.-'
#                     `"'--...___...--'"`
#
#


# grab the user input...
read -p "Enter your name: " NAME
read -e -p "Domain list path: " FILENAME
read -e -p "Results path: " SAVE_FILE

# make sure the paths get expanded...
eval NAME=$NAME
eval FILENAME=$FILENAME
eval SAVE_FILE=$SAVE_FILE

# create the column headers...
echo "Domain Name|Is Available?|Author" >> $SAVE_FILE

# Check to see what's available and what's not...
while read DOMAIN || [[ -n "$DOMAIN" ]]
do
  if whois $DOMAIN | grep -q "No match for";
  then
    echo "Processing $DOMAIN..."
    echo "$DOMAIN|yes|$NAME" >> $SAVE_FILE
  else
    echo "Processing $DOMAIN..."
    echo "$DOMAIN|no|$NAME" >> $SAVE_FILE
  fi
done <$FILENAME

echo "done!"
