#this file contains scripts for db admin tasks...
#creating and persisting data for the blog app using postgres container
#create a docker volume to persist data...

#create db container and connect

docker volume create dbvol

sudo apt install azure-cli

docker run --name postgres -e POSTGRES_PASSWORD=postgres -v dbvol:/var/lib/postgresql/data -p 5432:5432 -d postgres

docker exec -it 038ac8cf021e psql -U postgres -d postgres


#if running container table for first time, create this table
    CREATE TABLE blog_post (
            id SERIAL PRIMARY KEY, 
            title VARCHAR (250) NOT NULL, date VARCHAR (250) NOT NULL, 
            body TEXT NOT NULL, author VARCHAR (250) NOT NULL, 
            img_url VARCHAR (250) NOT NULL, subtitle VARCHAR (250) NOT NULL, 
            UNIQUE (title)
            );


#create logging table
CREATE TABLE visitor_log (
	"id"	SERIAL PRIMARY KEY,
	"time"	TIMESTAMP WITHOUT TIME ZONE,
	"ip_address"	TEXT,
	"message"	TEXT);



timestamp [ (p) ] [ without time zone ]


#create snapshot

#trigger azure function to create snapshot...


#first kill container
docker kill $(containder_id)


#now run az snapshot... have to login first.
az snapshot create --resource-group blogapp --name blogsnapshot --source postgres_OsDisk_1_e0f0f2447c7e453c9a2a8079d6086dc8


#start up db again
docker run --name postgres -e POSTGRES_PASSWORD=postgres -v dbvol:/var/lib/postgresql/data -p 5432:5432 -d postgres


#troubleshooting

docker exec -it c30e025381da env | grep POSTGRES_URI


#install azcopy



#copy to storage using azcopy

dbvol

/var/lib/docker/volumes/dbvol


#tried using az storage copy... ended up crashing the vm. Had to shut down the container to be avble to run it. so this wasnt ideal.
az storage file copy

#use az file to copy the postgres data...
sudo azcopy copy '/var/lib/docker/volumes/dbvol' 'https://blogappimages.file.core.windows.net/postgresbackup/?sv=2021-12-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2023-03-27T02:16:18Z&st=2023-03-26T18:16:18Z&spr=https&sig=GeCuWvJ2hfREnNb6hmdBNFatiGlJQT0cd04BhaJaAN0%3D' --recursive=true

sudo docker run --name postgres-exporter -e DATA_SOURCE_NAME="postgresql://postgres:postgres@localhost:5432/?sslmode=disable" -p 9187:9187 wrouesnel/postgres_exporter


docker run \
  --net=host \
  -e DATA_SOURCE_NAME="postgresql://postgres:postgres@localhost:5432/postgres?sslmode=disable" \
  quay.io/prometheuscommunity/postgres-exporter







#snapshot with az cli
az snapshot create --resource-group blogapp --name blogsnapshot --source postgres_OsDisk_1_e0f0f2447c7e453c9a2a8079d6086dc8


az snapshot create --resource-group blogapp --name blogsnapshot --source postgres_OsDisk_1_e0f0f2447c7e453c9a2a8079d6086dc8