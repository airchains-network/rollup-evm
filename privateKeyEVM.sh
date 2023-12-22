#!/bin/bash
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }
CONFIG_FILE="../config/config.json"
KEY=$(jq -r '.chainInfo.key' $CONFIG_FILE)

./build/aircosmicd keys unsafe-export-eth-key $KEY

