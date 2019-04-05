echo "================= DROPPING BIGCHAIN DATABASE ================="
bigchaindb -y drop
echo "================= CLOSING BIGCHAINDB PROCESSES, IF THEY EXIST ================="
kill -9 $(ps aux | grep "bigchaindb" | awk '{print $2}')
echo "================= STOPPING MONIT ================="
monit quit
echo "================= RESETTING TENDERMINT CONFIGURATIONS ================="
tendermint unsafe_reset_all
tendermint unsafe_reset_priv_validator
echo "================= DELETING TENDERMINT FOLDER ================="
rm -r -v $HOME/.tendermint/
echo "================= CREATE TENDERMINT FOLDER ================="
tendermint init
echo -e "\n\n"
echo "if you wish, it's time to change configs on tendermint folder ($HOME/.tendermint/config/config.toml)"
read -p "press [ENTER] to continue..."
echo -e "\n"
echo "================= STARTING MONIT ================="
monit -d 1
echo "================= STARTING BIGCHAINDB ================="
bigchaindb start
