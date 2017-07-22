#!/bin/bash

genDir="$(pwd)/generated"
keysFile="$genDir/account_keys.txt"
genesis="genesis.json"
initialTime=`date --date 'now + 30 minutes' +%FT%T`
hashedTime=`echo $initialTime | sha256sum | cut -d ' ' -f 1`

# Check if directory exists
if [ ! -d "$genDir" ]; then
    mkdir -p "$genDir"
fi

# Generate a new account and transfer over to account_keys.txt
if [ ! -e $keysFile ]; then
    ./keys_generator > $keysFile
fi


# Extract the keys respectively to their own variables
PUB_KEY=`grep -oP "Public key:\s+\K\w+" $keysFile`
PRIV_KEY=`grep -oP "Private key:\s+\K\w+" $keysFile`
echo "Keys extracted"

# Copy the template to generated folder at be edited
cp templates/genesis.json_template $genDir/$genesis

sed -i -e "s/__initialtimestamp__/$initialTime/g" "$genDir/$genesis"
sed -i -e "s/__pubkey__/$PUB_KEY/g" "$genDir/$genesis"
sed -i -e "s/__chainid__/$hashedTime/g" "$genDir/$genesis"

echo "Chain ID taken from current date: $hashedTime"
echo "Done Generating. Check $genDir/$genesis"


#1. CP to generated
#2. edit genesis
#3. get pubkey
#4. generate chain id
#5. enjoy
