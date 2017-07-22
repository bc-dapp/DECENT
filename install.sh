#!/bin/bash

# All the scripts are taken inside the scripts folder
# This install.sh is merely the main function to execute them
# Comment out unwanted scripts if reinstalling (i.e Boost)


init () {
    ./scripts/decent_run.sh init
}

#remake () {
    #cd DECENT-Network-build
    #cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DGRAPHENE_EGENESIS_JSON="$origDir/generated/genesis.json" $origDir/DECENT-Network
    #cmake --build . --target all -- -j -l 3.0
    #cmake --build . --target install
#}

#run decent with flag
run () {
    ./scripts/decent_run.sh run
}

scriptsDir="scripts"

# Prerequisites
echo "Installing prerequisites..."
chmod +x $scriptsDir/prereq.sh
./$scriptsDir/prereq.sh

 Boost Library
echo "Installing Boost..."
BOOST_ROOT="~/opt/boost_1_60_0"

if [ ! -d "$BOOST_ROOT" ]; then
    chmod +x $scriptsDir/boost_install.sh 
    ./$scriptsDir/boost_install.sh
fi

## For generatking keys and config
echo "Generating config file..."
chmod +x $scriptsDir/gen_config.sh
./$scriptsDir/gen_config.sh

## For generating the genesis file. 
echo "Generating genesis..."
chmod +x $scriptsDir/gen_genesis.sh
./$scriptsDir/gen_genesis.sh

chmod +x $scriptsDir/decent_install.sh
./$scriptsDir/decent_install.sh

chmod +x $scriptsDir/decent_run.sh
echo -e "\n\nInitializing ....\n\n"
init
echo -e "\n\nRunning...\n\n"
run

$@
