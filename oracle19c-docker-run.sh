#!/bin/bash
#

docker run -d --rm --name oracle --hostname oracle19c \
	-p 1521:1521 -p 1522:1522 \
	--memory=4g --memory-swap=4g \
	-e AUTO_MEM_CALCULATION=true \
	-e 'ORACLE_PWD=P4ssw0rd' \
	-e "TZ=$(cat /etc/timezone)" \
	-e 'DISPLAY=:1' \
	-v /dev/shm --tmpfs /dev/shm:rw,exec \
	-v /mnt/samsung512GB/var/lib/oracle19c/data-pdb:/opt/oracle/oradata \
	-v /mnt/samsung512GB/var/lib/oracle19c/myScripts:/opt/oracle/scripts/startup \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	oracle/database:19.3.0-ee

#	-e ENABLE_TCPS=true \
#	-e INIT_SGA_SIZE=1400 \
#	-e INIT_PGA_SIZE=1400 \

