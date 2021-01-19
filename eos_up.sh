#!/bin/bash

DATADIR=$HOME"/localnet/blockchain"
BOOTDIR=$HOME"/localnet/boot"
LOGDIR=$HOME"/localnet/logs"

EOS_PUB_DEV_KEY="EOS5AYFrVpWouKXyhHdFCZbh6KdvcrEAq2FS8ih7xH6L9fCo2UsFH"
EOS_PRIV_DEV_KEY="5KkLkV7sr9JdYELxYVaaGpz1mCN5UVJn5FEL2CovPvdjJF7n4FH"


if [ ! -d $DATADIR ]; then
    mkdir -p $DATADIR
fi

if [ ! -d $LOGDIR ]; then
    mkdir -p $LOGDIR
fi

nodeos \
--signature-provider $EOS_PUB_DEV_KEY=KEY:$EOS_PRIV_DEV_KEY \
--plugin eosio::producer_plugin \
--plugin eosio::producer_api_plugin \
--plugin eosio::chain_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::history_api_plugin \
--plugin eosio::history_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--producer-name eosio \
--http-server-address 127.0.0.1:8888 \
--p2p-listen-endpoint 127.0.0.1:9010 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
--p2p-peer-address localhost:9011 \
--p2p-peer-address localhost:9012 \
--p2p-peer-address localhost:9013 \
>> $LOGDIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid"