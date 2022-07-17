#!/bin/bash
#

	docker run -d --name apex-ords \
		-p 8888:8080 \
		--memory=1536m \
		--env-file /home/container/dockerfiles/apex-ords/docker.env \
		chaosengine/apex-ords

