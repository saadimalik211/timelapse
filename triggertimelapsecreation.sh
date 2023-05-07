#!/bin/bash

#check for "updatetimelapse" in stills, and trigger the timelapse creation script.

if [ -e /home/saad/piproject/timelapse/stills/updatetimelapse ]
then
  /home/saad/piproject/timelapse/createtimelapse.sh
  rm -f /home/saad/piproject/timelapse/stills/updatetimelapse
fi

