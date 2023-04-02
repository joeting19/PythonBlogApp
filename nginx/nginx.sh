

sudo docker run -d --name nginx-base -p 80:80 nginx:latest


docker exec -it nginx-base /bin/bash


sudo docker cp nginx-base:/etc/nginx/conf.d/default.conf ~/

#sudo docker cp nginx-base:/etc/nginx/nginx.conf ~/nginx.conf


#edit nginx.conf to treat css as css and html as html

#sudo docker cp nginx.conf nginx-base:/etc/nginx/
#edit default.conf to 

sudo docker cp default.conf nginx-base:/etc/nginx/conf.d/


sudo docker exec nginx-base nginx -t
sudo docker exec nginx-base nginx -s reload




















nginx.conf