 sudo systemctl start docker

 sudo systemctl start docker
sudo chmod 666 /var/run/docker.sock



 docker pull joeting91/pythonblog:dev

#for dev
docker run -d -p 80:80 joeting91/pythonblog:dev