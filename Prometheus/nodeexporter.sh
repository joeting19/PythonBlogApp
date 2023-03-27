#regular node exporter
wget https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
./node_exporter



#postgres exporter container
sudo docker run --name postgres-exporter -e DATA_SOURCE_NAME="postgresql://postgres:postgres@localhost:5432/?sslmode=disable" -p 9187:9187 wrouesnel/postgres_exporter


