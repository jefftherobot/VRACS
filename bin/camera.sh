#!/bin/sh

cvlc v4l2:///dev/video0:width=320:height=240 --sout '#transcode{vcodec=mjpg,scale=1,fps=30,vb=4000}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=:8080}' --quiet --daemon &
