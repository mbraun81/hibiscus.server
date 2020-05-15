#!/bin/bash -e
CONTAINER_NAME=hibiscus.server
IMAGE_NAME=hibiscus.server

if [ "$(docker ps -qf name=$CONTAINER_NAME 2>/dev/null)" ]; then
	echo "stop $CONTAINER_NAME"
	docker stop $CONTAINER_NAME
fi

if [ "$(docker container ls -aqf name=$CONTAINER_NAME 2>/dev/null)" ]; then
	echo "remove container: $CONTAINER_NAME"
	docker rm $CONTAINER_NAME
fi

if [ "$(docker image ls -aqf reference=$IMAGE_NAME 2>/dev/null)" ]; then
	echo "remove image: $IMAGE_NAME"
	docker rmi -f $IMAGE_NAME
fi

docker build . -t $IMAGE_NAME && \
docker run --name $CONTAINER_NAME -dit $IMAGE_NAME && \
docker exec -it $CONTAINER_NAME /bin/bash