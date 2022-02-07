mkdir -p node1/data
mkdir -p node2/data
mkdir -p node3/data
mkdir -p node4/data

# create the config file

besu operator generate-blockchain-config --config-file=ibftConfigFile.json --to=networkFiles --private-key-file-name=key

# move genesis.json from network files to main directory
# move each key and public key from network files to their respective node file

# in node1:
besu --data-path=data --genesis-file=../genesis.json --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all"

# in node2 (open another terminal):
besu --data-path=data --genesis-file=../genesis.json --bootnodes=<Node-1 Enode URL> --p2p-port=30304 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8546

# important: <Node-1 Enode URL> can be found in node1's terminal once you have started it, node1 will be the core node

# in node3 (open another terminal):
besu --data-path=data --genesis-file=../genesis.json --bootnodes=<Node-1 Enode URL> --p2p-port=30305 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8547

# in node4 (open another terminal):
besu --data-path=data --genesis-file=../genesis.json --bootnodes=<Node-1 Enode URL> --p2p-port=30306 --rpc-http-enabled --rpc-http-api=ETH,NET,IBFT --host-allowlist="*" --rpc-http-cors-origins="all" --rpc-http-port=8548

# in another terminal:
curl -X POST --data '{"jsonrpc":"2.0","method":"ibft_getValidatorsByBlockNumber","params":["latest"], "id":1}' localhost:8545

# if the blockchain is working this should appear:
{
  "jsonrpc" : "2.0",
  "id" : 1,
  "result" : [ "0x1e326b6da177ede2d3eb6d7247bd9f6901d40234", "0x4aaac297fefe4466ebcb0b23ab90c5f466b11556", "0xa267ead2e91e1673e0943b925176b51d9cd4f6d2", "0xe3e680bc0ff485d1d415a384721f19e0db65fea7" ]
}
