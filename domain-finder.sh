#!/usr/bin/bin bash

#
# This is a super simple way to check for domain name availablility. Here's how it works:
#
#     - Run the script bash domain-finder.sh
#     - Enter your name
#     - Enter the filename containing domain names to check (one per line)
#     - Enter the path to save results
#
# The script will use whois and grep for the string "No match for" and output the data as a tab
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
read -e -p "Filename: " FILENAME
read -e -p "Path to save results: " SAVE_FILE

# make sure the paths get expanded...
eval NAME=$NAME
eval FILENAME=$FILENAME
eval SAVE_FILE=$SAVE_FILE

# create the column headers...
echo "Domain Name\tIs Available?\tAuthor" >> $SAVE_FILE

# Check to see what's available and what's not...
cat $FILENAME | while read DOMAIN
do
  if whois $DOMAIN | grep -q "No match for";
  then
    echo "Processing $DOMAIN...done!"
    echo "$DOMAIN\tyes\t$NAME" >> $SAVE_FILE
  else
    echo "Processing $DOMAIN...done!"
    echo "$DOMAIN\tno\t$NAME" >> $SAVE_FILE
  fi
done

echo "done!"