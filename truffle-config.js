const HDWalletProvider = require("truffle-hdwallet-provider-klaytn");
const ACCOUNT = require('./config/account.js');
const privateKey = ACCOUNT.PRIVATE_KEY; // Enter your private key;


/**
 * truffle network variables
 * for deploying contract to klaytn network.
 */
 const NETWORK_ID = '1001'

 /**
  * URL: URL for the remote node you will be using
  * PRIVATE_KEY: Private key of the account that pays for the transaction (Change it to your own private key)
  */
 const URL = 'https://api.baobab.klaytn.net:8651'
 
 // Paste your `Private key` that has enough KLAY to truffle.js
 const PRIVATE_KEY = privateKey;
 
 module.exports = {
   networks: {
     baobab: {
       provider: () => new HDWalletProvider(PRIVATE_KEY, URL),
       network_id: NETWORK_ID,
       gas: '8500000',
       gasPrice: null,
     },
   },
 
   // Specify the version of compiler, we use 0.5.6
   compilers: {
     solc: {
       version: '0.5.6',
     },
   },
 }

/*
module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    testnet: {
      provider: () => new HDWalletProvider(privateKey, "https://api.baobab.klaytn.net:8651"),
      network_id: '1001', //Klaytn baobab testnet's network id
      gas: '8500000',
      gasPrice: null
    },
    mainnet: {
      provider: () => new HDWalletProvider(privateKey, "https://your.cypress.en.url:8651"),
      network_id: '8217', //Klaytn mainnet's network id
      gas: '8500000',
      gasPrice: null
    }
  },
  compilers: {
    solc: {
      version: "0.5.6"
    }
  }
};
*/

