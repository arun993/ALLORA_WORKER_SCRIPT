#!/bin/bash

# Step 0: Update and install necessary packages
echo "Updating system and installing required packages..."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y git docker.io docker-compose

# Step 1: Clone the repository
git clone https://github.com/allora-network/allora-offchain-node

# Step 2: Change to the cloned directory
cd allora-offchain-node

# Step 3: Copy the example config to config.json
cp config.example.json config.json

# Step 4: Get user input for the required fields
read -p "Enter the address key name (addressKeyName): " addressKeyName
read -p "Enter the address restore mnemonic (addressRestoreMnemonic): " addressRestoreMnemonic
nodeRpc="https://sentries-rpc.testnet-1.testnet.allora.network/"

# Step 5: Edit config.json with user input
sed -i "s/\"addressKeyName\": \"\"/\"addressKeyName\": \"$addressKeyName\"/g" config.json
sed -i "s/\"addressRestoreMnemonic\": \"\"/\"addressRestoreMnemonic\": \"$addressRestoreMnemonic\"/g" config.json
sed -i "s#\"nodeRpc\": \"\"#\"nodeRpc\": \"$nodeRpc\"#g" config.json

# Step 6: Load the config.json to environment
chmod +x init.config
./init.config

# Step 7: Start a new screen session
screen -S allora -dm bash -c 'docker compose up --build'

# Step 8: Attach to the screen session (optional)
echo "To attach to the screen session, run: screen -r allora"

