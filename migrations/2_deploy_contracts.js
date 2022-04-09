const fs = ("browserify-fs");
const DIDLedger = artifacts.require("./DIDLedger.sol");
const DIDUtils = artifacts.require("./DIDUtils.sol");
const DIDStorage = artifacts.require('./DIDStorage.sol');

module.exports = function(deployer) {
  deployer.deploy(DIDStorage);
  deployer.deploy(DIDUtils); //library
  deployer.link(DIDUtils, DIDLedger);
  deployer.deploy(DIDLedger);
  /*
  deployer.deploy(DIDStorage)
    .then(() => {
    if (DIDStorage._json) {
      // 1. Record recently deployed contract's abi file to 'deployedABI'
      fs.writeFile(
        'deployedABIDIDStorage',
        JSON.stringify(DIDStorage._json.abi, 2),
        (err) => {
          if (err) throw err
          console.log(`The abi of ${DIDStorage._json.contractName} is recorded on deployedABI file`)
        });
    }

    // 2. Record recently deployed contract's address to 'deployedAddress'
    fs.writeFile(
      'deployedAddressDIDStorage',
      DIDStorage.address,
      (err) => {
        if (err) throw err
        console.log(`The deployed contract address * ${DIDStorage.address} * is recorded on deployedAddress file`)
    });
  });
*/

};