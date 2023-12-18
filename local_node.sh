#!/bin/bash

./build/aircosmicd version

rm -rf ./private/.ethermintapp

./build/aircosmicd init demo --home ./private/.ethermintapp --chain-id air_1337-1

cat ./private/.ethermintapp/config/genesis.json

./build/aircosmicd keys list \
    --home ./private/.ethermintapp \
    --keyring-backend test

./build/aircosmicd keys add alice \
    --home ./private/.ethermintapp \
    --keyring-backend test

./build/aircosmicd keys show alice \
    --home ./private/.ethermintapp \
    --keyring-backend test


grep bond_denom ./private/.ethermintapp/config/genesis.json

./build/aircosmicd add-genesis-account alice 100000000stake \
    --home ./private/.ethermintapp \
    --keyring-backend test

grep -A 10 balances ./private/.ethermintapp/config/genesis.json

./build/aircosmicd gentx alice 70000000stake \
    --home ./private/.ethermintapp \
    --keyring-backend test \
    --chain-id air_1337-1


./build/aircosmicd collect-gentxs \
    --home ./private/.ethermintapp


./build/aircosmicd start \
    --home ./private/.ethermintapp


# NEW CODES 

./build/aircosmicd keys unsafe-export-eth-key mykey\
    --home ./private/.ethermintapp\
    --keyring-backend test

