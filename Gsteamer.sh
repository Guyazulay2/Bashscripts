#!/bin/sh

clear
echo "--- Checks if plugins is installed in Gstreamer ---" ; sleep 2

while read line; do

    for plugin in $line; do

        sleep 0.1
        if 'gst-inspect-1.0' | grep -q $plugin
        then

        echo "$plugin = installed !"

        else
        echo "$plugin = Not installed !"

        fi

        done

done <"2.txt"
echo "Done"
