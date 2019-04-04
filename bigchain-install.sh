echo "============= STARTING ============="
sudo apt update
sudo apt full-upgrade
echo "============= INSTALLING PIP3 ============="
sudo apt install -y python3-pip libssl-dev
echo "============= INSTALLING BIGCHAINDB ============="
sudo pip3 install bigchaindb==2.0.0b9
echo "============= SETTING ============="
bigchaindb configure
echo "============= INSTALLING MONGO ============="
sudo apt install mongodb
echo "============= INSTALLING TENDERMINT ============="
sudo apt install -y unzip
wget https://github.com/tendermint/tendermint/releases/download/v0.22.8/tendermint_0.22.8_linux_amd64.zip
unzip tendermint_0.22.8_linux_amd64.zip
rm tendermint_0.22.8_linux_amd64.zip
sudo mv tendermint /usr/local/bin
echo "============= STARTING TENDERMINT ============="
tendermint init
echo "============= PLEASE WRITE YOUR NODE NAME ($HOME/.tendermint/config/genesis.json) ============="
echo "\n"
read -p "...Press enter to continue.."
echo "\n"
echo "============= INSTALLING MONIT ============="
sudo apt install monit
echo "============= SETTING MONIT ============="
bigchaindb-monit-config
monit -d 1
echo "============= INSTALLATION COMPLETED SUCCESSFULLY ============="
echo "============= STARTING BIGCHAINDB ============="
bigchaindb start
