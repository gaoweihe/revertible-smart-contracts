const Callee = artifacts.require("Callee");
const Caller = artifacts.require("Caller");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(Callee);
  deployer.deploy(Caller); 
};