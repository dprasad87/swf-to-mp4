# swf to mp4

Docker container to convert any flash (swf) to mp4.

To build, you can do the following:

```
docker build -t dprasad/convert-swf .
```



And then to run, the container expects an input swf file as first argument, and
an mp4 argument as the second. We do everything in a `/data` directory that we map on the host.
The container expect the input swf filename as argument. It reads the file from /data mapped to the the parent directory of the swf file.
```
docker run dprasad/convert-swf -v /<dir in host system>:/data input.swf
```

To convert swf files in a directory -
```
sh convert.sh directory
```
or To convert a swf_file -
```
sh conert.sh <path to swf_file>
```

Happy converting!
