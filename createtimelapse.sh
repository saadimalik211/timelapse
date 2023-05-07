#!/bin/bash

#define paths
stills_path=/home/saad/piproject/timelapse/stills
install_path=/home/saad/piproject/timelapse

#clear out low quality images (typically the ones snapped at night)
find $stills_path -name "*.jpg" -type 'f' -size -1200k -delete

#create list of the jpgs to feed to mencoder
ls "$stills_path/"*".jpg" > $install_path/stills.txt

#create new timelapse from latest stills
mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1920:1080 -o $install_path/new.avi -mf type=jpeg:fps=12 mf://@stills.txt

#take current timelapse, and merge it with the new one.

if [ -e $install_path/old.avi ]
then
  mencoder -oac copy -ovc copy $install_path/old.avi $install_path/new.avi -o $install_path/tmp.avi
else
  mv $install_path/new.avi $install_path/tmp.avi
fi

mv $install_path/tmp.avi $install_path/old.avi
cp -rf $install_path/old.avi $install_path/timelapse.avi

#cleanup
rm -f $install_path/stills.txt
rm -f "$stills_path/"*".jpg"
