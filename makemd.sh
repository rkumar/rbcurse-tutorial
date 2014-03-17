#!/bin/bash
## vim:ts=4:sw=4:tw=100:ai:nowrap:formatoptions=croqln:
#*******************************************************#
#                      makemd                        #
#                 written by Rahul Kumar                #
#                    2014/03/17                         #
#   Runs main.rb on any .page file that is newer than
#   the html file, or also if the template has changed
#   after the html was generated.
#*******************************************************#

## convert page files to md files since github does not show
## html in formatted 

template=${1:-"template/plain.md"}
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

for var in $SRC/*.page; do
    #echo "$var"
    htm=$(echo "$var" | sed "s#src/#md/#g;s/\.page$/.md/g")
    #echo ">> $htm"
    if [[ $var -nt $htm || $template -nt $htm  ]]; then
        echo "recreating $var to $htm"
        ./mainmd.rb $var $template > $htm
    fi
done

