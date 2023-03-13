#shell script to prepare for ubuntu 20.04 to host webapp

sudo apt update
sudo apt install git
git clone https://github.com/joeting19/PythonBlogApp.git
cd PythonBlogApp
sudo apt install python3.8-venv -y
python3 -m venv venv
source venv/bin/activate
python3 -m pip install -r requirements.txt
