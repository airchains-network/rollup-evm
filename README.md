![Project Logo](https://www.airchains.io/assets/logos/airchains-evm-rollup-full-logo.png) 

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction
The EVM-based Cosmos Chain is a cutting-edge platform for building decentralized applications (DApps) and smart contracts. Leveraging the scalability of Cosmos and the flexibility of the Ethereum Virtual Machine, our platform offers a unique environment for blockchain developers.

## Features
- **EVM Compatibility:** Seamlessly run Ethereum smart contracts on Cosmos.
- **High Scalability:** Utilize Cosmos' advanced scalability features for DApps.
- **Interoperability:** Connect with multiple blockchains within the Cosmos ecosystem.

## Getting Started
To get started with the EVM-based Cosmos Chain, clone this repository using:

```shell
git clone https://github.com/airchains-network/rollup-evm.git
```

### Prerequisites
List any prerequisites here, such as software versions, environment setup, etc.

- [Go](https://golang.org/doc/install) (version 1.20+)
- [Node.js](https://nodejs.org/en/download/) (version 14.17+)
- [Jq](https://stedolan.github.io/jq/download/)

### Installation
Provide step-by-step installation instructions, like so:

# Step 1

## Configuration Setup

To properly configure the EVM-based Cosmos Chain, you need to set up a `config.json` file in the `config` folder.


### Creating the Config Folder and File

1. **Create the Config Folder:** Create a new folder named `config` in the root directory of the project. Use the following command in your terminal:

   ```bash
   mkdir config
2. **Create the Config File:** Create a new file named `config.json` in the `config` folder. Use the following command in your terminal:

   ```bash
    touch config/config.json
    ```
### Configuring the Config File

```bash
{
  "chainInfo": 
    {
        "chainID":  "aircosmic_5501-1107",
        "key":      "dummy",
        "moniker":  "test-evm-rollup"
    }
}
```


# Step 2
To Start a New Chain with the default configuration, run the following command:

```
sh init.sh
```

# Step 3
To Restart the Chain from the Same Block Height Where Stopped, run the following command:

```
sh restart.sh
```







## Credits
This project is built upon the foundations laid by the following remarkable repositories:

- [Ethermint](https://github.com/cosmos/ethermint): Ethermint is a scalable, high-throughput Proof-of-Stake blockchain that is fully compatible and interoperable with Ethereum. Our project leverages Ethermint's robust framework, which is built using the Cosmos SDK and runs on the Tendermint Core consensus engine. We appreciate and acknowledge the groundbreaking work done by the Ethermint team and their contributions to the open-source community.


## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


