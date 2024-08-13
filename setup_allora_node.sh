#!/bin/bash

# Update and install necessary packages
echo "Updating system and installing required packages..."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y git docker.io docker-compose

# Clone the repository
echo "Cloning the Allora offchain node repository..."
git clone https://github.com/allora-network/allora-offchain-node.git

# Navigate to the cloned directory
cd allora-offchain-node

# Copy the example config to a new config file
echo "Creating config.json from config.example.json..."
cp config.example.json config.json

# Add wallet name, mnemonic, and RPC URL
echo "Please enter your wallet name:"
read WALLET_NAME
echo "Please enter your mnemonic:"
read MNEMONIC
RPC_URL="https://sentries-rpc.testnet-1.testnet.allora.network/"

# Replace the placeholders in the config.json
sed -i "s/YOUR_WALLET_NAME/$WALLET_NAME/" config.json
sed -i "s/YOUR_MNEMONIC/$MNEMONIC/" config.json
sed -i "s~YOUR_RPC_URL~$RPC_URL~" config.json

# Make the init.config script executable
echo "Making init.config executable..."
chmod +x init.config

# Run the init.config script
echo "Running the init.config script..."
./init.config

# Build and run the Docker container
echo "Building and running the Docker container..."
docker-compose up --build

echo "Allora offchain node setup completed successfully - Follow x.com/arun__993 for more ."
