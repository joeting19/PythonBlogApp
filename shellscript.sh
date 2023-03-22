#this shell script for for CI/CD docker container
IMAGE_NAME='joeting91/pythonblog:latest'
CONTAINER=$(docker ps | grep $IMAGE_NAME | awk '{print $1;}')
docker kill $CONTAINER
docker pull $IMAGE_NAME
docker run -d -p 80:80 $IMAGE_NAME



IMAGE_NAME='joeting91/pythonblog:latest' \
CONTAINER=$(docker ps | grep $IMAGE_NAME | awk '{print $1;}') \
docker kill $CONTAINER \
docker pull $IMAGE_NAME \
docker run -d -p 80:80 $IMAGE_NAME


