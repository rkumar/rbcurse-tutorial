#!/bin/bash
## vim:ts=4:sw=4:tw=100:ai:nowrap:formatoptions=croqln:
#*******************************************************#
#                      makeme.sh                        #
#                 written by Rahul Kumar                #
#                    2010/05/05                         #
#   Runs main.rb on any .page file that is newer than
#   the html file, or also if the template has changed
#   after the html was generated.
#*******************************************************#

# --------------------------------------------------------- #
# cleanup_pfiles ()                                         #
# Removes all files in designated directory.                #
# Parameter:                                                #
# Returns:                                                  #
# --------------------------------------------------------- #



template=${1:-"template/plain.htm"}
if [ $# -eq 0 ]
then
    echo "I got no template name using $template"
    #exit 1
    #else
    #echo "Got $*"
    #echo "Got $1"
fi
today=$(date +"%Y-%m-%d-%H%M")
SRC=src
OUT=html

for var in $SRC/*.page; do
    #echo "$var"
    htm=$(echo "$var" | sed "s#src/#html/#g;s/\.page$/.html/g")
    #echo ">> $htm"
    if [[ $var -nt $htm || $template -nt $htm  ]]; then
        echo "recreating $var to $htm"
        ./main.rb $var $template > $htm
    fi
done

