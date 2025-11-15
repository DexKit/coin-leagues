import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import "hardhat-gas-reporter";

import "hardhat-deploy-ethers";
import "hardhat-deploy";
//import "@symfoni/hardhat-react";
//import "hardhat-typechain";
import "hardhat-contract-sizer";

import * as dotenv from "dotenv";

dotenv.config();

const { ALCHEMY_API, ALCHEMY_POLYGON_API, PRIVATE_KEY, MENMONIC } = process.env;
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
export default {
  react: {
    providerPriority: ["web3modal", "hardhat"],
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: true,
    disambiguatePaths: false,
  },
  solidity: {
    compilers: [
      {
        version: "0.8.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.6.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  networks: {
    /*hardhat: {
      forking: {
        url: `https://eth-mainnet.alchemyapi.io/v2/${ALCHEMY_API}`,
        blockNumber: 12956195,
      },
      accounts: {
        count: 100
      }
    },*/
    hardhat: {
      forking: {
        url: `https://polygon-rpc.com/`,
        blockNumber: 23260291,
      },
      accounts: {
        count: 100,
      },
    },
    amoy:{
      url: 'https://rpc-amoy.polygon.technology',
      accounts: [PRIVATE_KEY],
      gasPrice: 65000000000,
    //  gasPrice:  40000000000,
    },

    mumbai: {
      url: "https://matic-mumbai.chainstacklabs.com",
      accounts: [PRIVATE_KEY],
    },
    matic: {
      url: `https://polygon-rpc.com/`,
      accounts: [PRIVATE_KEY],
      gasPrice: 80000000000,
    },
    base: {
      url: `https://mainnet.base.org`,
      accounts: [PRIVATE_KEY],
    },
    bsc: {
      url: `https://bsc.blockrazor.xyz`,
      accounts: [PRIVATE_KEY],
      gasPrice: 800000000,
    }
  },
  gasReporter: {
    enabled: true,
  },
  mocha: {
    timeout: 2000000,
  },
};
