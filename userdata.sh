#set up Ubuntu server by installing docker
sudo apt update -y
sudo apt install docker.io -Y
sudo systemctl start docker
sudo usermod -aG docker ${USER}
sudo chmod 666 /var/run/docker.sock




