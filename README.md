![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/dwaaan/hrconvert2-docker.svg)![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/dwaaan/hrconvert2-docker.svg) [![](https://images.microbadger.com/badges/image/dwaaan/hrconvert2-docker.svg)](https://microbadger.com/images/dwaaan/hrconvert2-docker )

# HRConvert2-Docker V2.9.2 (ubuntu:21.10)

Docker files for HRConvert2 from https://github.com/zelon88/HRConvert2 - A self-hosted, drag-and-drop, & nosql file conversion server that supports 62x file formats.

## Docker Hub
https://hub.docker.com/r/johannesk13/k13-repo
docker pull johannesk13/k13-repo:hrconvert2


## Dockerfile (Building the image yourself)

1. git clone https://github.com/JoeKravelli/HRConvert2-Docker
2. Edit config.php
3. Set Ubuntu repos in Dockerfile (currently set to Australia)
4. docker build -t hrconvert2 .
5. docker images,copy the image ID
6. docker run -i -t hrconvert2
 

## docker-compose.yml

1. git clone https://github.com/JoeKravelli/HRConvert2-Docker
2. Edit config.php
3. docker-compose up (-d to run in background)

## hrconvert2-up.sh

execute script for fully working document conversion
-> This will spin up container with docker-compose & start unoconv listener
