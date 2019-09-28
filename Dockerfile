FROM ubuntu:16.04
# docker build -t dprasad/swf-to-mp4 .

RUN apt-get update
RUN apt-get install -y mplayer
RUN apt-get install -y gnash
RUN apt-get install -y ffmpeg
RUN mkdir /data
WORKDIR /data
ADD swf_to_mp4.sh /
ADD convert-swf.sh /
RUN chmod u+x /swf_to_mp4.sh
RUN chmod u+x /convert-swf.sh
ENTRYPOINT ["/convert-swf.sh"]
