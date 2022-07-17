#!/bin/bash
#

docker run -d --rm --name oracle --hostname oracle19c \
	-p 1521:1521 -p 5500:5500 \
	--memory=4g --memory-swap=4g \
	-e INIT_SGA_SIZE=1400 \
	-e INIT_PGA_SIZE=1400 \
	-e 'ORACLE_PWD='P4ssw0rdssword1235678 \
	-e "TZ=$(cat /etc/timezone)" \
	-e 'DISPLAY=:1' \
	-v /dev/shm --tmpfs /dev/shm:rw,exec \
	-v /mnt/samsung512GB/var/lib/oracle19c/data-pdb:/opt/oracle/oradata \
	-v /mnt/samsung512GB/var/lib/oracle19c/myScripts:/opt/oracle/scripts/startup \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	oracle/database:19.3.0-ee

#	-e INIT_SGA_SIZE=980 \
#	-e INIT_PGA_SIZE=420 \

