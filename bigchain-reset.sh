red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${red}================= DROPPING BIGCHAIN DATABASE =================${reset}"
bigchaindb -y drop
echo "${red}================= CLOSING BIGCHAINDB PROCESSES, IF THEY EXIST =================${reset}"
kill -9 $(ps aux | grep "bigchaindb" | awk '{print $2}')
echo "${red}================= STOPPING MONIT =================${reset}"
monit quit
echo "${red}================= RESETTING TENDERMINT CONFIGURATIONS =================${reset}"
tendermint unsafe_reset_all
tendermint unsafe_reset_priv_validator
echo "${red}================= DELETING TENDERMINT FOLDER =================${reset}"
rm -r -v $HOME/.tendermint/
echo "${red}================= CREATE TENDERMINT FOLDER =================${reset}"
file="config.toml"
if [ -f "$file" ]
then
	echo "${green} $file found. Copying file to tendermint folder.${reset}"
	mkdir -v $HOME/.tendermint
	mkdir -v $HOME/.tendermint/config
	cp -v config.toml $HOME/.tendermint/config/config.toml
else
	echo "${green} $file not found. Using default file${reset}"
fi
tendermint init
echo "${red}================= STARTING MONIT =================${reset}"
monit -d 1
echo "${red}================= STARTING BIGCHAINDB =================${reset}"
bigchaindb start
