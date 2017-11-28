Usage
-----
**Init database**
```text
docker run -it -rm -e "BIFROST_DB_DSN=postgres://stellar:1q2w3e@192.168.1.36/bifrost?sslmode=disable" docker-stellar-bifrost init
```

**Launch bifrost server**
```text
docker run -it -e "BIFROST_CFG={}" docker-stellar-bifrost server
```
where `BIFROST_CFG` content (sample):
```json
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
``` 
Following ENV variables can be used to override/set key values of `BIFROST_CFG`
* `BIFROST_BITCOIN_RPC_SERVER`
* `BIFROST_ETHEREUM_RPC_SERVER`
* `BIFROST_STELLAR_ISSUER_PUBLIC_KEY`
* `BIFROST_STELLAR_SIGNER_SECRET_KEY`
* `BIFROST_STELLAR_HORIZON`
* `BIFROST_DB_TYPE`
* `BIFROST_DB_DSN`

Set variables below to you want move forward starting point of the blockchains' block scanning
* `ETHEREUM_LAST_BLOCK`
* `BITCOIN_LAST_BLOCK`
