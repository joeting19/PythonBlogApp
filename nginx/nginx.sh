#commands to set up docker container as reverse proxy for webapp

sudo docker run -d --name nginx-base -p 80:80 nginx:latest

docker exec -it nginx-base /bin/bash

sudo docker cp nginx-base:/etc/nginx/conf.d/default.conf ~/

sudo docker cp default.conf nginx-base:/etc/nginx/conf.d/

sudo docker exec nginx-base nginx -t
sudo docker exec nginx-base nginx -s reload


#note... i ended up going with NGINX on server itself rather than container




#scripts for running on VM and not Container.

#check presence of module
nginx -V 2>&1 | grep -o with-http_realip_module

nginx -V 2>&1 | grep -o http_healthcheck_module


#check config file
sudo nginx -t

#graceful reload
sudo systemctl reload nginx

#full restart
sudo systemctl restart nginx

sudo systemctl status nginx

tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log







nginx.conf