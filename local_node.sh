#!/bin/bash

./build/ethermintd version

rm -rf ./private/.ethermintapp

./build/ethermintd init demo --home ./private/.ethermintapp --chain-id air_1337-1

cat ./private/.ethermintapp/config/genesis.json

./build/ethermintd keys list \
    --home ./private/.ethermintapp \
    --keyring-backend test

./build/ethermintd keys add alice \
    --home ./private/.ethermintapp \
    --keyring-backend test

./build/ethermintd keys show alice \
    --home ./private/.ethermintapp \
    --keyring-backend test


grep bond_denom ./private/.ethermintapp/config/genesis.json

./build/ethermintd add-genesis-account alice 100000000stake \
    --home ./private/.ethermintapp \
    --keyring-backend test

grep -A 10 balances ./private/.ethermintapp/config/genesis.json

./build/ethermintd gentx alice 70000000stake \
    --home ./private/.ethermintapp \
    --keyring-backend test \
    --chain-id air_1337-1


./build/ethermintd collect-gentxs \
    --home ./private/.ethermintapp


./build/ethermintd start \
    --home ./private/.ethermintapp


# NEW CODES 

./build/ethermintd keys unsafe-export-eth-key mykey\
    --home ./private/.ethermintapp\
    --keyring-backend test

