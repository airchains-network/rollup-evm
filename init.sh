#!/bin/bash


# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }

CONFIG_FILE="./config/config.json"
KEY=$(jq -r 'chainInfo.key' $CONFIG_FILE)
CHAINID=$(jq -r '.chainInfo.chainID' $CONFIG_FILE)
MONIKER=$(jq -r 'chainInfo.moniker' $CONFIG_FILE)
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# trace evm
TRACE="--trace"
# TRACE=""


# remove existing daemon and client
rm -rf ~/.aircosmicd*

make build

./build/aircosmicd config keyring-backend $KEYRING
./build/aircosmicd config chain-id $CHAINID

# if $KEY exists it should be deleted
./build/aircosmicd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Ethermint (Moniker can be anything, chain-id must be an integer)
./build/aircosmicd init $MONIKER --chain-id $CHAINID

# Change parameter token denominations to aphoton
cat $HOME/.aircosmicd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="aphoton"' > $HOME/.aircosmicd/config/tmp_genesis.json && mv $HOME/.aircosmicd/config/tmp_genesis.json $HOME/.aircosmicd/config/genesis.json
cat $HOME/.aircosmicd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="aphoton"' > $HOME/.aircosmicd/config/tmp_genesis.json && mv $HOME/.aircosmicd/config/tmp_genesis.json $HOME/.aircosmicd/config/genesis.json
cat $HOME/.aircosmicd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="aphoton"' > $HOME/.aircosmicd/config/tmp_genesis.json && mv $HOME/.aircosmicd/config/tmp_genesis.json $HOME/.aircosmicd/config/genesis.json
cat $HOME/.aircosmicd/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="aphoton"' > $HOME/.aircosmicd/config/tmp_genesis.json && mv $HOME/.aircosmicd/config/tmp_genesis.json $HOME/.aircosmicd/config/genesis.json

# Set gas limit in genesis
cat $HOME/.aircosmicd/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="20000000"' > $HOME/.aircosmicd/config/tmp_genesis.json && mv $HOME/.aircosmicd/config/tmp_genesis.json $HOME/.aircosmicd/config/genesis.json

# Allocate genesis accounts (cosmos formatted addresses)
./build/aircosmicd add-genesis-account $KEY 100000000000000000000000000aphoton --keyring-backend $KEYRING

# Sign genesis transaction
./build/aircosmicd gentx $KEY 1000000000000000000000aphoton --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
./build/aircosmicd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
./build/aircosmicd validate-genesis

# disable produce empty block and enable prometheus metrics
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.aircosmicd/config/config.toml
    sed -i '' 's/prometheus = false/prometheus = true/' $HOME/.aircosmicd/config/config.toml
    sed -i '' 's/prometheus-retention-time = 0/prometheus-retention-time  = 1000000000000/g' $HOME/.aircosmicd/config/app.toml
    sed -i '' 's/enabled = false/enabled = true/g' $HOME/.aircosmicd/config/app.toml
else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.aircosmicd/config/config.toml
    sed -i 's/prometheus = false/prometheus = true/' $HOME/.aircosmicd/config/config.toml
    sed -i 's/prometheus-retention-time  = "0"/prometheus-retention-time  = "1000000000000"/g' $HOME/.aircosmicd/config/app.toml
    sed -i 's/enabled = false/enabled = true/g' $HOME/.aircosmicd/config/app.toml
fi

if [[ $1 == "pending" ]]; then
    echo "pending mode is on, please wait for the first block committed."
    if [[ $OSTYPE == "darwin"* ]]; then
        sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.aircosmicd/config/config.toml
    else
        sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.aircosmicd/config/config.toml
        sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.aircosmicd/config/config.toml
    fi
fi

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
./build/aircosmicd start --metrics --pruning=nothing --evm.tracer=json $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001aphoton --json-rpc.api eth,txpool,personal,net,debug,web3,miner --api.enable 
