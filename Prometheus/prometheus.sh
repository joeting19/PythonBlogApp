#this has code to prepare prometheus



#for Prometheus instance
docker build -t my-prometheus .
docker run -dt -p 9090:9090 my-prometheus




