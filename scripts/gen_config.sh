#!/bin/bash

genDir="$(pwd)/generated"
keysFile="$genDir/account_keys.txt"

hashedTime=`date +%s | sha256sum`
# Check if directory exists
if [ ! -d "$genDir" ]; then
    mkdir -p "$genDir"
fi

# Generate a new account and transfer over to account_keys.txt
if [ ! -f $keysFile ]; then
    ./keys_generator > $keysFile
fi

# Generate a new account and transfer over to account_keys.txt
if [ ! -f "$keysFile" ]; then
    ./keys_generator > $keysFile
fi

# Extract the keys respectively to their own variables
PUB_KEY=`grep -oP "Public key:\s+\K\w+" $keysFile`
PRIV_KEY=`grep -oP "Private key:\s+\K\w+" $keysFile`
echo "Keys extracted"


cp templates/config.ini_template $genDir/config.ini

sed -i -e "s/pubkey/$PUB_KEY/g" "$genDir/config.ini"
sed -i -e "s/privkey/$PRIV_KEY/g" "$genDir/config.ini"

echo "New config.ini file created in $genDir/config.ini"
echo "Finished configuring config.ini"
