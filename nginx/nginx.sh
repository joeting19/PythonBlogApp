#commands to set up docker container as reverse proxy for webapp

sudo docker run -d --name nginx-base -p 80:80 nginx:latest

docker exec -it nginx-base /bin/bash

sudo docker cp nginx-base:/etc/nginx/conf.d/default.conf ~/

sudo docker cp default.conf nginx-base:/etc/nginx/conf.d/

sudo docker exec nginx-base nginx -t
sudo docker exec nginx-base nginx -s reload


#note... i ended up going with NGINX on server itself rather than container














nginx.conf