require('@nomiclabs/hardhat-ethers');
require('@nomiclabs/hardhat-waffle');
require('@nomiclabs/hardhat-etherscan');
require('@openzeppelin/hardhat-upgrades');

require('dotenv').config();

if (process.env.ENABLE_GAS_REPORT == 'true') {
  require('hardhat-gas-reporter');
}

const accounts = process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [];

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    hardhat: {
      allowUnlimitedContractSize: false,
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`,
      // url: `https://eth-mainnet.alchemyapi.io/v2/_EERO6pmOXNoI3CjVZDIiZuKF362kLgb`,
      accounts,
    },
    ropsten: {
      url: `https://ropsten.infura.io/v3/${process.env.INFURA_API_KEY}`,
      // url: `https://eth-ropsten.alchemyapi.io/v2/xPdevR7gRNJrl83Fh7ZV2oA177AbABIH`,
      accounts,
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  gasReporter: {
    enabled: (process.env.ENABLE_GAS_REPORT == 'true') ? true : false,
    currency: 'USD',
  },
  solidity: {
    compilers: [
      {
        version: '0.8.9',
      },
      {
        version: '0.4.23',
      },
    ],
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
      metadata: {
        // do not include the metadata hash, since this is machine dependent
        // and we want all generated code to be deterministic
        // https://docs.soliditylang.org/en/v0.8.9/metadata.html
        bytecodeHash: 'none',
      },
    },
  },
};

if (process.env.COVERAGE) {
  require('solidity-coverage');
  module.exports.networks.hardhat.initialBaseFeePerGas = 0;
}
