#!/bin/bash

# Define variables
SEED_NODE_IP="192.1.168.32:26656"
SEED_NODE_ID="d27015f43a1b5de64ecda0f99ac00a0de34f3d95"
CHAIN_ID="aircosmic_5501-1107"
NODE_NAME="aircosmic-node-1"

# Initialize the Ethermint node with the specified chain ID
ethermintd init $NODE_NAME --chain-id=$CHAIN_ID

# Copy the genesis file from the seed node
cp ./seed-genesis.json ~/.ethermintd/config/genesis.json

# Update the persistent peers in the config.toml file
sed -i "s/persistent_peers = \"\"/persistent_peers = \"$SEED_NODE_ID@$SEED_NODE_IP:26656\"/g" ~/.ethermintd/config/config.toml

# Start the Ethermint node
ethermintd start
