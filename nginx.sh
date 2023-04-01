

sudo docker run -d --name nginx-base -p 80:80 nginx:latest

sudo docker cp nginx-base:/etc/nginx/conf.d/default.conf ~/Desktop/default.conf