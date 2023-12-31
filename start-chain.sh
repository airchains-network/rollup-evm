# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
LOGLEVEL="info"
TRACE="--trace"
./build/aircosmicd start --metrics --pruning=nothing --evm.tracer=json $TRACE --log_level $LOGLEVEL --minimum-gas-prices=0.0001aphoton --json-rpc.api eth,txpool,personal,net,debug,web3,miner --api.enable
