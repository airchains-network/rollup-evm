#!/bin/bash

rm -rf ~/.aircosmicd

command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }
CONFIG_FILE="../config/mutlinode-config.json"


# Define variables
SEED_NODE_ID=$(jq -r '.chainInfo.nodeID' $CONFIG_FILE)
SEED_NODE_IP=$(jq -r '.chainInfo.ipAddress' $CONFIG_FILE)
CHAIN_ID=$(jq -r '.chainInfo.chainID' $CONFIG_FILE)
NODE_NAME=$(jq -r '.chainInfo.nodeName' $CONFIG_FILE)
if [ -z "$SEED_NODE_ID" ] || [ -z "$SEED_NODE_IP" ] || [ -z "$CHAIN_ID" ]|| [ -z "$NODE_NAME" ] ; then
    echo "Error: One or more values could not be fetched from the JSON file."
    exit 1
else
    # Echo the values
    echo "$SEED_NODE_ID: $SEED_NODE_ID"
    echo "$SEED_NODE_IP: $SEED_NODE_IP"
    echo "$CHAIN_ID: $CHAIN_ID"
    echo "$NODE_NAME: $NODE_NAME"
fi

# Initialize the Ethermint node with the specified chain ID
./build/aircosmicd init $NODE_NAME --chain-id=$CHAIN_ID

# Copy the genesis file from the seed node

#cp ./seed-genesis.json ~/.aircosmicd/config/genesis.json

# Copy the genesis file from the seed node
if [ -e ./seed-genesis.json ]; then
  cp ./seed-genesis.json ~/.aircosmicd/config/genesis.json
  echo "Fle copied successfully!"
else
  echo "Error: File not present. Please make sure the file exists."
    exit 1
fi



# Update the persistent peers in the config.toml file
sed -i "s/persistent_peers = \"\"/persistent_peers = \"$SEED_NODE_ID@$SEED_NODE_IP:26656\"/g" ~/.aircosmicd/config/config.toml

#Start the Ethermint node
./build/aircosmicd start
