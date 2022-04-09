const Migrations = artifacts.require("./Migrations.sol");
const DIDLedger = artifacts.require("./DIDLedger.sol");
const DIDUtils = artifacts.require("./DIDUtils.sol");
const DIDStorage = artifacts.require("./DIDStorage.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
//   deployer.deploy(DIDStorage);
//   deployer.deploy(DIDUtils); //library
//   deployer.link(DIDUtils, DIDLedger);
//   deployer.deploy(DIDLedger);
// 
};