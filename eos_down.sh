#!/bin/bash

DATADIR=$HOME"/localnet/blockchain"
BOOTDIR=$HOME"/localnet/boot"
LOGDIR=$HOME"/localnet/logs"

if [ -f $DATADIR"/eosd.pid" ]; then
    pid=`cat $DATADIR"/eosd.pid"`
    echo $pid
    kill $pid
    rm -r $DATADIR"/eosd.pid"
    echo -ne "Stopping node ."
    while true; do
        [ ! -d "/proc/$pid/fd" ] && break
        echo -ne "."
        sleep 1
    done
    echo -ne "\rNode stopped.\n"
    echo -ne "\rDeleting nodelog\n"
    rm -rf $LOGDIR
fi