#!/bin/bash

repoRoot="$(pwd)"

remake () {
    buildDir="$repoRoot/DECENT-Network-build"
    cd $buildDir
    cmake -G "Unix Makefiles" -DBOOST_ROOT=$(realpath ~/opt/boost_1_60_0) -DCMAKE_BUILD_TYPE=Debug $repoRoot/DECENT-Network
    cp $repoRoot/generated/genesis.json libraries/egenesis/
    cp $repoRoot/generated/genesis.json $repoRoot
    make
}

if [ ! -d ~/opt/boost_1_60_0 ]; then
    echo "Cannot find boost 1.60"
    exit
fi

# Store the repo root
 ##Clone the repo.
git clone https://github.com/DECENTfoundation/DECENT-Network.git
cd DECENT-Network
mv libraries/egenesis/genesis.json libraries/egenesis/genesis.json_backup 
cp $repoRoot/generated/genesis.json libraries/egenesis/
git submodule update --init --recursive

## Build and install Decent.
mkdir -p $repoRoot/DECENT-Network-build
buildDir="$repoRoot/DECENT-Network-build"
cd $buildDir
rm -r *

# cmake links to boost 1.60 installation from ~/opt/
# Embeds genesis file too. No need to add --genesis-json flag when running decentd
cmake -G "Unix Makefiles" -DBOOST_ROOT=$(realpath ~/opt/boost_1_60_0) -DCMAKE_BUILD_TYPE=Debug $repoRoot/DECENT-Network
cp $repoRoot/generated/genesis.json libraries/egenesis/
cp $repoRoot/generated/genesis.json $repoRoot
make

echo "Installed"


$@

# Commands below are the original instructions for offical docs

#cp $repoRoot/generated/genesis.json .
#cmake -DBOOST_ROOT=$(realpath ~/opt/boost_1_60_0) -DGRAPHENE_EGENESIS_JSON="$repoRoot/generated/genesis.json" $repoRoot/DECENT-Network
#make
#make install
#cmake --build . --target all -- -j -l 3.0
#cmake --build . --target install



#cd $buildDir
#mkdir -p data
#cp $repoRoot/generated/config.json data/

#cd $repoRoot
#.$buildDir/programs/decentd/decentd -d data

#1. Get decent 
#2. Make with genesis embedded https://github.com/DECENTfoundation/DECENT-Network/wiki/private-testnet#embedding-genesis-optional
#3. Create files with datafile and config copied
