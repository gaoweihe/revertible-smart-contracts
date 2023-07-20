const RLExecutor = artifacts.require("RLExecutor");
const RLInstructor = artifacts.require("RLInstructor");

module.exports = function(deployer) {
  // deployment steps
  var RLExecutor_addr;
  deployer.deploy(RLExecutor, {overwrite: true}).then(async () => {
    RLExecutor_addr = RLExecutor.address; 
    await deployer.deploy(RLInstructor, RLExecutor_addr, {overwrite: true}); 
  });
};