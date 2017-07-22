#!/bin/bash

# Boost 1.60.0 installation. The Boost version that comes with Ubuntu 16.04 is only 1.55.0

mkdir -p ~/DECENTfoundation/DECENT-Network-third-party && \
cd ~/DECENTfoundation/DECENT-Network-third-party && \
rm -rf boost_1_60_0* boost-1.60.0* && \
wget -O boost_1_60_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz/download && \
tar xzvf boost_1_60_0.tar.gz && \
mkdir -p ~/opt/boost_1_60_0 && \
cd boost_1_60_0 && \
export BOOST_ROOT=$(realpath ~/opt/boost_1_60_0) && \
./bootstrap.sh --prefix=$BOOST_ROOT && \
./b2 install

echo "Boost 1.60.0 installed"
