const SmartContractB = artifacts.require("SmartContractB");

module.exports = function(deployer) {
  // deployment steps
  var SmartContractB_addr;
  deployer.deploy(SmartContractB, {overwrite: true}).then(async () => {
    SmartContractB_addr = SmartContractB.address; 
    // await deployer.deploy(RLInstructor, RLExecutor_addr, {overwrite: true}); 
  });
};