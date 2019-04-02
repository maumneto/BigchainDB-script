# Code to initiaze the bigchainDB 
echo " ========== STARTING BIGCHAINDB ============ "

# cleaning the BD for new transactions
echo "Do you want clean the database? [y/n]"
read user
if [$user -eq "y" || $user -eq "Y"]; then
    bigchaindb -y drop
    echo " ------------------------------------------- " 
    echo "       CLEANING ALL PAST TRANSACTIONS        "
    echo " ------------------------------------------- "
else 
    echo "DATABASE STILL SAVED!"
fi


# monit started
monit -d 1
echo " ============== MONIT ON =================== "

# start bigchaindb
bigchaindb start 
echo " ------------------------------------------- " 
echo "             START THE BIGCHAINDB            "
echo " ------------------------------------------- "
# end code!
echo " ----------- FINISH INITIALIZED! ------------- "