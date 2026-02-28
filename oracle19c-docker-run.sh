#!/bin/bash
#

: "${ORACLE_PWD:?ORACLE_PWD must be set}"

docker run -d --rm --name oracle --hostname oracle19c \
	-p 1521:1521 \
	--memory=4g --memory-swap=4g \
	-e AUTO_MEM_CALCULATION=true \
	-e "ORACLE_PWD=${ORACLE_PWD}" \
	-e "TZ=$(cat /etc/timezone)" \
	-v /dev/shm --tmpfs /dev/shm:rw,exec \
	-v /mnt/optane15GB/var/lib/oracle19c/data-pdb:/opt/oracle/oradata \
	-v /mnt/optane15GB/var/lib/oracle19c/myScripts:/opt/oracle/scripts/startup \
	oracle/database:19.29.0-patched

#tight VNC vars
#	-e 'DISPLAY=:1' \
#	-v /tmp/.X11-unix:/tmp/.X11-unix \

	#oracle/database:19.3.0-ee
#	-e ENABLE_TCPS=true \
#	-e INIT_SGA_SIZE=1400 \
#	-e INIT_PGA_SIZE=1400 \

