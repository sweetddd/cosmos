rm -rf build
ignite chain build --output ./build

./build/exampled init demo --home ./build --chain-id ethermint_9-9

cat ./build/config/genesis.json \

./build/exampled keys list --home ./build --keyring-backend test

./build/exampled keys add alice --home ./build --keyring-backend test --algo eth_secp256k1


./build/exampled keys list --home ./build --keyring-backend test

./build/exampled keys show alice --home ./build --keyring-backend test

grep bond_denom ./build/config/genesis.json

./build/exampled add-genesis-account alice 100000000aphoton --home ./build --keyring-backend test

grep -A 10 balances ./build/config/genesis.json

./build/exampled gentx alice 70000000aphoton --home ./build --keyring-backend test --chain-id ethermint_9-9

./build/exampled collect-gentxs --home ./build

./build/exampled start --home ./build