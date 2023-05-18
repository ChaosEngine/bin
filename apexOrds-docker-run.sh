#!/bin/bash
#

	docker run -d --name apex-ords \
		-p 8888:8080 -p 1898:1898 \
		--memory=1280m \
		--env-file /home/container/dockerfiles/apex-ords/docker.env \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e 'DISPLAY=:1' \
		chaosengine/apex-ords

