#!/bin/sh

if [ -f "/tmp/lofisong.txt" ]; then
    echo "Song list already exits"
else
    curl -s "https://lofigirl.com/blogs/releases" | grep "Cv_release_mini_wrap_img" | cut -d "\"" -f2 | cut -d "/" -f4 > /tmp/lofialbum.txt

    echo "album list downloaded"

    while read line
        do
            curl -s "https://lofigirl.com/blogs/releases/$line" | grep "data-audio-src" | cut -d "\"" -f4 >> /tmp/lofisong.txt
            echo "$line"
        done < /tmp/lofialbum.txt

    echo "song list downloaded"
fi

aria2c --auto-file-renaming=false -t 600 --download-result=hide -i "/tmp/lofisong.txt" -d "$HOME/TrueHome/Music/lofigirl/"

notify-send -u critical "ARIA2C" "LOFI SONGS Downloaded"
