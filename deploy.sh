DOCKER_IMAGE=esso4real/pipeline:v29
docker pull $DOCKER_IMAGE
docker run -d -p 8085:8085 $DOCKER_IMAGE
