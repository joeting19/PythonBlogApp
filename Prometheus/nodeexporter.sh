#download node exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar xvfz node_exporter-1.5.0.linux-amd64.tar.gz
cd node_exporter-1.5.0.linux-amd64



#create user
sudo groupadd -f node_exporter
sudo useradd -g node_exporter --no-create-home --shell /bin/false node_exporter
sudo mkdir /etc/node_exporter
sudo chown node_exporter:node_exporter /etc/node_exporter


#move binary
tar -xvf node_exporter-1.5.0.linux-amd64.tar.gz
mv node_exporter-1.5.0.linux-amd64 node_exporter-files

#Install Node Exporter

sudo cp node_exporter-files/node_exporter /usr/bin/
sudo chown node_exporter:node_exporter /usr/bin/node_exporter


#create config file
sudo vi /usr/lib/systemd/system/node_exporter.service

#add following code to file
[Unit]
Description=Node Exporter
Documentation=https://prometheus.io/docs/guides/node-exporter/
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
Restart=on-failure
ExecStart=/usr/bin/node_exporter \
  --web.listen-address=:9100

[Install]
WantedBy=multi-user.target




sudo chmod 664 /usr/lib/systemd/system/node_exporter.service

sudo systemctl daemon-reload
sudo systemctl start node_exporter

sudo systemctl enable node_exporter.service

./node_exporter



#postgres exporter container
sudo docker run --name postgres-exporter -e DATA_SOURCE_NAME="postgresql://postgres:postgres@localhost:5432/?sslmode=disable" -p 9187:9187 wrouesnel/postgres_exporter


