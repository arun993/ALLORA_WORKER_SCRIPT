#!/bin/bash

# Step 0: Update and install necessary packages
echo "Updating system and installing required packages..."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y git docker.io docker-compose

# Step 1: Git clone the repository
echo "Cloning the Allora offchain node repository..."
git clone https://github.com/allora-network/allora-offchain-node.git

# Step 2: Navigate to the cloned directory
cd allora-offchain-node || { echo "Failed to navigate to allora-offchain-node directory"; exit 1; }

# Step 3: Create the config.json file
echo "Creating config.json file..."
touch config.json

# Step 4: Download the config.example.json and save it as config.json
echo "Downloading config.example.json and copying to config.json..."
wget https://raw.githubusercontent.com/allora-network/allora-offchain-node/dev/config.example.json -O config.json

# Step 5: Get user input for wallet name, mnemonic, and RPC URL
echo "Please enter your wallet name:"
read WALLET_NAME
echo "Please enter your mnemonic:"
read MNEMONIC
RPC_URL="https://sentries-rpc.testnet-1.testnet.allora.network/"

# Step 6: Modify the placeholders in config.json
echo "Replacing placeholders in config.json..."
sed -i "s/YOUR_WALLET_NAME/$WALLET_NAME/" config.json
sed -i "s/YOUR_MNEMONIC/$MNEMONIC/" config.json
sed -i "s~YOUR_RPC_URL~$RPC_URL~" config.json

# Step 7: Make the init.config script executable and run it
echo "Making init.config executable and running it..."
chmod +x init.config
./init.config

# Step 8: Build and run the Docker container
echo "Building and running the Docker container..."
docker-compose up --build

echo "Worker node upgrade completed successfully!! Follow x.com/arun__993 for more ."
