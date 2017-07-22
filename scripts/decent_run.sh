#!/bin/bash

repoRoot=$(pwd)
decentd="$(pwd)/DECENT-Network-build/programs/decentd/decentd -d data"

init () {
    cp $repoRoot/generated/genesis.json .
    timeout 5 $decentd --genesis-json genesis.json
    cp genesis.json data/
    cp $repoRoot/generated/config.ini data/
    timeout 5 $decentd --genesis-timestamp 10
}

run () {
    if [ ! -d data ]; then
        echo -e "No data file. Run command \n ./install.sh init \n"
        exit
    fi

    if [ ! -e data/genesis.json ]; then
        echo "No genesis.json file found in data folder on repo root. Try again"
        exit
    fi

    $decentd
}

$@
