#create db container and connect

docker run --name postgres -e POSTGRES_PASSWORD=P@ssW0rd! -d postgres
docker exec -it 2b2b5950fe05 psql -U postgres -d postgres

    CREATE TABLE blog_post (
            id SERIAL PRIMARY KEY, 
            title VARCHAR (250) NOT NULL, date VARCHAR (250) NOT NULL, 
            body TEXT NOT NULL, author VARCHAR (250) NOT NULL, 
            img_url VARCHAR (250) NOT NULL, subtitle VARCHAR (250) NOT NULL, 
            UNIQUE (title)
            );

