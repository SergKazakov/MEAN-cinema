# NodeJS
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
source $HOME/.nvm/nvm.sh
nvm i stable
nvm alias default stable
sudo apt-get install -y build-essential libssl-dev

# MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Others
sudo apt-get install -y git
npm i -g gulp bower nodemon coffee-script npm-check-updates bower-update