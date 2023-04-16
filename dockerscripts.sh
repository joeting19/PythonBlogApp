 
sudo systemctl start docker
sudo chmod 666 /var/run/docker.sock



docker pull joeting91/pythonblog:dev


#for dev
docker run -d -p 5000:5000 --name pythonblog joeting91/pythonblog:dev



IMAGE_NAME='joeting91/pythonblog:dev' 
CONTAINER=$(docker ps | grep $IMAGE_NAME | awk '{print $1;}') 
docker kill $CONTAINER 
docker pull $IMAGE_NAME
docker run -d -p 5000:5000 $IMAGE_NAME


#for prod

docker pull joeting91/pythonblog:latest

docker run -d -p 5000:5000 --name pythonblog joeting91/pythonblog:latest


docker run -d -p 5001:5000 joeting91/pythonblog:latest
