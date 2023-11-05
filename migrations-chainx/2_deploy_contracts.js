const SmartContractA = artifacts.require("SmartContractA");

module.exports = function(deployer) {
  // deployment steps
  var SmartContractA_addr;
  deployer.deploy(SmartContractA, {overwrite: true}).then(async () => {
    SmartContractA_addr = SmartContractA.address; 
    // await deployer.deploy(RLInstructor, RLExecutor_addr, {overwrite: true}); 
  });
};