const fs = require("fs");
const DIDLedger = artifacts.require("./DIDLedger.sol");
const DIDUtils = artifacts.require("./DIDUtils.sol");
const DIDStorage = artifacts.require("./DIDStorage.sol");
module.exports = function(deployer) {
  deployer.deploy(DIDUtils)
  .then(() => {
  if (DIDUtils._json) {
    // 1. Record recently deployed contract's abi file to 'deployedABI'
    fs.writeFile(
      './res/abi/deployedABIDIDUtils',
      JSON.stringify(DIDUtils._json.abi, 2),
      (err) => {
        if (err) throw err
        console.log(`The abi of ${DIDUtils._json.contractName} is recorded on deployedABI file`)
      })
  }

  // 2. Record recently deployed contract's address to 'deployedAddress'
  fs.writeFile(
    './res/address/deployedAddressDIDUtils',
    DIDUtils.address,
    (err) => {
      if (err) throw err
      console.log(`The deployed contract address * ${DIDUtils.address} * is recorded on deployedAddress file`)
  })
});

  deployer.deploy(DIDStorage)
    .then(() => {
    if (DIDStorage._json) {
      // 1. Record recently deployed contract's abi file to 'deployedABI'
      fs.writeFile(
        './res/abi/deployedABIDIDStorage',
        JSON.stringify(DIDStorage._json.abi, 2),
        (err) => {
          if (err) throw err
          console.log(`The abi of ${DIDStorage._json.contractName} is recorded on deployedABI file`)
        })
    }

    // 2. Record recently deployed contract's address to 'deployedAddress'
    fs.writeFile(
      './res/address/deployedAddressDIDStorage',
      DIDStorage.address,
      (err) => {
        if (err) throw err
        console.log(`The deployed contract address * ${DIDStorage.address} * is recorded on deployedAddress file`)
    })
  });

  deployer.link(DIDUtils, DIDLedger);
  deployer.link(DIDStorage, DIDLedger);

  deployer.deploy(DIDLedger)
    .then(() => {
    if (DIDLedger._json) {
      // 1. Record recently deployed contract's abi file to 'deployedABI'
      fs.writeFile(
        './res/abi/deployedABIDIDLedger',
        JSON.stringify(DIDLedger._json.abi, 2),
        (err) => {
          if (err) throw err
          console.log(`The abi of ${DIDLedger._json.contractName} is recorded on deployedABI file`)
        })
    }

    // 2. Record recently deployed contract's address to 'deployedAddress'
    fs.writeFile(
      './res/address/deployedAddressDIDLedger',
      DIDLedger.address,
      (err) => {
        if (err) throw err
        console.log(`The deployed contract address * ${DIDLedger.address} * is recorded on deployedAddress file`)
    })
  });

};