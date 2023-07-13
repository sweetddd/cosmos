#!/bin/bash

rm -rf onenode

go build -o ./onenode/exampled example/cmd/exampled

./onenode/exampled init node0 --chain-id testnet_9-6 --home onenode

./onenode/exampled keys add dev0 --home onenode --keyring-backend os

jq '.app_state["staking"]["params"]["bond_denom"]="eth"' onenode/config/genesis.json >onenode/config/tmp_genesis.json && mv onenode/config/tmp_genesis.json onenode/config/genesis.json
jq '.app_state["crisis"]["constant_fee"]["denom"]="eth"' onenode/config/genesis.json >onenode/config/tmp_genesis.json && mv onenode/config/tmp_genesis.json onenode/config/genesis.json
jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="eth"' onenode/config/genesis.json >onenode/config/tmp_genesis.json && mv onenode/config/tmp_genesis.json onenode/config/genesis.json
jq '.app_state["evm"]["params"]["evm_denom"]="eth"' onenode/config/genesis.json >onenode/config/tmp_genesis.json && mv onenode/config/tmp_genesis.json onenode/config/genesis.json
jq '.app_state["inflation"]["params"]["mint_denom"]="eth"' onenode/config/genesis.json >onenode/config/tmp_genesis.json && mv onenode/config/tmp_genesis.json onenode/config/genesis.json

# Set gas limit in genesis
jq '.consensus_params["block"]["max_gas"]="10000000"' onenode/config/genesis.json >onenode/config/tmp_genesis.json && mv onenode/config/tmp_genesis.json onenode/config/genesis.json

./onenode/exampled add-genesis-account dev0 100000000000000000000000000eth --keyring-backend os --home onenode

./onenode/exampled gentx  dev0 1000000000000000000000eth --home onenode  --keyring-backend os --chain-id testnet_9-6

./onenode/exampled collect-gentxs --home onenode

./onenode/exampled keys unsafe-export-eth-key dev0 --home onenode  --keyring-backend os

TRACE=""

## Start the node (remove the --pruning=nothing flag if historical queries are not needed)
./onenode/exampled start --metrics "$TRACE" --log_level="info" --minimum-gas-prices=0.0001eth --json-rpc.api eth,txpool,personal,net,debug,web3 --api.enable --home onenode