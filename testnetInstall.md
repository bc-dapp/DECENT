# DECENT Testnet Setup

All written instructions are for setting up DECENT Network testnet. This is not the only guide to be followed as I may have missed certain steps. Refer to [Official DECENT Docs](https://github.com/DECENTfoundation/DECENT-Network/wiki/private-testnet)

# Generating Keys

Use `program/keys_generator/keys_generator`. The output will be something similar to: (Public Key will have a prefix of DCT)

    Brain key:    FLAKILY OUTGUN RODHAM BEAUX DEWATER BHAVA SONNET ADMIRER TOPH BANKER MISPAGE TELLER JIBBAH UNFINED DOWNCRY MULLID
    Private key:  5JwkqrYHsXtxQwVdi1qQnjodAfPCv2RmHGUPQQhCzFQN6bzhjXv
    Public key:   DCT5jwSywTwSwd3MDfVoDbBKRwaroBBf6mVq7zQJcPaDLZQaiVfTU

Copy these keys and save them somewhere safe (example: ./keysgenerator > ../account.txt)

# Generate Genesis file

Go to where `decentd` was built and open it with flags `--create-genesis-json genesis.json`. Example: 

    programs/decentd/decentd --create-genesis.json genesis.json

The resulting file `genesis.json` should now be generated. Edit it with the keys above.

## Another way...

Copy the `genesis.json` of decent and change the keys. Example:

    cp DECENT-Network/genesis.json genesis.json
    (editor) genesis.json

_Note: (editor) should be your preferred editor like vim, nano, gedit, etc._

Remove the other decent accounts that are different from the majority of the keys. Don't forget to change the name. Along with this file is a sample genesis file. Do not use it as the prefix is different. Looking carefully, there is only 1 key among all the objects. Decent has multiple keys for multiple people.
Also, don't forget to change the `chain_id`

# Creating the config file

Run the following to generate a `config.ini` file for the blockchain.

    artifacts/prefix/bin/decentd --data-dir data/my_block 

The `data` folder should exist. The above command will create a folder named `personal_block` inside `data`.

With your editor of choice, edit `data/my_block/config.ini`. Change the following:

    p2p-endpoint = 127.0.0.1:11010
    genesis-json = genesis.json

    private-key = ["YOUR-PUBLIC-KEY", "YOUR-PRIVATE-KEY"]
    miner-id = "1.4.5"

    enable-stale-production=true

The `private-key` variable should be those ones added inside the genesis file.

# Run the testnet

    artifacts/prefix/bin/decentd --data-dir data/my_block --genesis-json genesis.json

At this point, it should all be running fine. If there are no errors, it should start generating blocks after awhile. Scroll up to look for `chain-id`. Copy the value and save it somewhere. It will be used for `CLI_WALLET`

# Using `CLI_WALLET`

Run `cli_wallet` with a provided wallet file (optional) and chain-id derived from running decentd.

    artifacts/prefix/bin/cli_wallet --wallet-file my-wallet.json --chain-id 19b7e44b5d90d7fccfb005f2fd8999d618910b7bd6383e79d9710443640814be
