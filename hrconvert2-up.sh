#!/bin/bash

docker-compose up -d

sleep 2

docker exec -it -u root hrconvert2 bash -c "/wait-for-it.sh 172.17.0.1:8086 --timeout=10 --strict -- echo hrconvert2-is-up"

sleep 2

docker exec -d -it -u www-data hrconvert2 /bin/bash -c "/usr/bin/unoconv --listener"

sleep 2

docker exec -d -it -u www-data hrconvert2 /bin/bash -c "/usr/bin/unoconv --listener"

sleep 2

docker exec -it -u www-data hrconvert2 bash -c "echo listener-is-up"

exec "$@"

