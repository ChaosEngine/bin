#!/bin/bash
#

docker run -d --rm --name oracle --hostname oracle23c \
	-p 1521:1521 -p 5500:5500 \
	--memory=4g --memory-swap=4g \
	-e INIT_SGA_SIZE=1600 \
	-e INIT_PGA_SIZE=1600 \
	-e 'ORACLE_PWD=P4ssw0rd' \
	-e "TZ=$(cat /etc/timezone)" \
	-e 'DISPLAY=:1' \
	-v /dev/shm --tmpfs /dev/shm:rw,exec \
	-v /mnt/optane15GB/var/lib/oracle23c/data-pdb:/opt/oracle/oradata \
	-v /mnt/optane15GB/var/lib/oracle23c/myScripts:/opt/oracle/scripts/startup \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	oracle/database:23.2.0-free

	#-e INIT_SGA_SIZE=1700 \
	#-e INIT_PGA_SIZE=1700 \

##	-e INIT_SGA_SIZE=1300 \
##	-e INIT_PGA_SIZE=676 \	

