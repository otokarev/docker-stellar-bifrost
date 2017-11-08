#!/usr/bin/env bash

read -r -d '' BIFROST_CFG << EOM
{
    "ethereum": {
        "master_public_key": "xpub6C79eBsW2XQbzfXFsRv51Lac6Ckx5nyqf9cUmFr1fuAEHGXmpq8oPNMqCpH1jTdwP3s5SD644R8KK4cVytk9Jxcxcb7JsfNxcGNRbG5q4pq",
        "rpc_server": "geth:8545",
        "network_id": "3",
        "minimum_value_eth": "0.00001"
    },
    "stellar": {
        "issuer_public_key": "GD5H2WSHTWVTZI5BR3V5XTRBCFDMEOKFMXR4Y4PU337K7WS55UAADI5T",
        "signer_secret_key": "SD4DFZ433RUGNCMCG4JGWK47R5KOHQOS4T5LXGLGBLY7ZLBUZQTTONVQ",
        "token_asset_code": "TOKE",
        "needs_authorize": "true",
        "horizon": "http://horizon:8000",
        "network_passphrase": "Test SDF Network ; September 2015"
    },
    "database": {
        "type": "postgres",
        "dsn": "postgres://stellar:1q2w3e@bifrost-db/bifrost?sslmode=disable"
    }
}
EOM
export BIFROST_CFG

./confd.bin -onetime -backend=env -confdir ./confd/ && cat /tmp/bifrost.cfg
