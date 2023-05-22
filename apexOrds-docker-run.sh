#!/bin/bash
#

	docker run -d --rm --name apex-ords \
		-p 8888:8080 -p 1898:1898 \
		--memory=3g \
		--env-file /home/container/dockerfiles/apex-ords/docker.env \
		chaosengine/apex-ords:1.0.10_24.2.11

#	-v /tmp/.X11-unix:/tmp/.X11-unix \
#	-e 'DISPLAY=:1' \
