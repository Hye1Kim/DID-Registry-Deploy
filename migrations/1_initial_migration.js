const Migrations = artifacts.require("./Migrations.sol");
const DIDLedger = artifacts.require("./DIDLedger.sol");
const DIDUtils = artifacts.require("./DIDUtils.sol");
const DIDStorage = artifacts.require("./DIDStorage.sol");
module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(DIDLedger);
  deployer.deploy(DIDUtils);
  deployer.deploy(DIDStorage);
};