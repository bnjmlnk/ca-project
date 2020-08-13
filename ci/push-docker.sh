#!/bin/bash

docker push "$docker_username/codeshan${GIT_COMMIT::4}" 
docker push "$docker_username/codeshan:latest" &
wait