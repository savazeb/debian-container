#!/usr/bin/env bash

TAG="${TAG:-latest}"

# check whether image exist or not
# if not docker will start build the Dockerfile
if [[ "$(docker images -q debian:${TAG} 2> /dev/null)" == "" ]]; then
  docker build --build-arg TAG=${TAG} -t debian .
fi

# cleanup the container
if [[ "$(docker ps -a | grep debian)" ]]; then
  echo "stop working container named debian..."
  docker stop debian
  docker rm debian
fi

# run the container
echo "run container in background..."
docker run -it -d --name debian -v ${PWD}/debian:/debian debian

# open the container shell
echo "starting..."
docker exec -it debian bash
