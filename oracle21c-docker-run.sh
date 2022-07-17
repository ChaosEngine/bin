#!/bin/bash
#

docker run -d --rm --name oracle --hostname oracle21c \
	-p 1521:1521 -p 5500:5500 \
	--memory=4g --memory-swap=5g \
	-e INIT_SGA_SIZE=1700 \
	-e INIT_PGA_SIZE=1700 \
	-e 'ORACLE_PWD=password12423556g' \
	-e "TZ=$(cat /etc/timezone)" \
	-e 'DISPLAY=:1' \
	-v /dev/shm --tmpfs /dev/shm:rw,exec \
	-v /mnt/samsung512GB/var/lib/oracle21c/data-pdb:/opt/oracle/oradata \
	-v /mnt/samsung512GB/var/lib/oracle21c/myScripts:/opt/oracle/scripts/startup \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	oracle/database:21.3.0-ee

#	-e INIT_SGA_SIZE=1300 \
#	-e INIT_PGA_SIZE=676 \	


#docker run -d --rm --name oracle --hostname oracle21c \
#	--memory=3g --memory-swap="4g" \
#	-p 1521:1521 -p 5500:5500 \
#	-e 'ORACLE_PWD=P4ssw0rd' \
#	-e "TZ=$(cat /etc/timezone)" \
#	-e 'DISPLAY=:1' \
#	-v /dev/shm --tmpfs /dev/shm:rw,exec \
#	-v /mnt/spare320GB/var/lib/oracle/data-pdb:/opt/oracle/oradata \
#	-v /mnt/spare320GB/var/lib/oracle/myScripts:/opt/oracle/scripts/startup \
#	-v /tmp/.X11-unix:/tmp/.X11-unix \
#	oracle/database:21.3.0-ee

