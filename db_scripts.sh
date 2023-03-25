#create db container and connect

docker run --name postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres

docker exec -it 52a607adb832 psql -U postgres -d postgres



docker exec -it 52a607adb832 env | grep POSTGRES_URI


    CREATE TABLE blog_post (
            id SERIAL PRIMARY KEY, 
            title VARCHAR (250) NOT NULL, date VARCHAR (250) NOT NULL, 
            body TEXT NOT NULL, author VARCHAR (250) NOT NULL, 
            img_url VARCHAR (250) NOT NULL, subtitle VARCHAR (250) NOT NULL, 
            UNIQUE (title)
            );

