video_large_retrieval
=====================

retrieval video in large scale



1. Input Data:

Input video Only uncompressed AVI movies on UNIX.
In the case of need to change format use ffmpeg

--$ ffmpeg -i input.avi -vcodec mjpeg -qscale 1 out.avi

to install ffmpeg :

--$ brew install ffmpeg
or 
--$ sudo apt-get install ffmpeg


To Build an Executable convert Scripts For The Mac OSX Command Line:

- use the sample convert.sh file in data folder
- FIREST : --$ chmod 777 ./conver.sh
- then : --$ ./conver.sh
