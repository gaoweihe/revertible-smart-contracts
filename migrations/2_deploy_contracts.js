const BasicPerf = artifacts.require("BasicPerf")

const RLExecutor = artifacts.require("RLExecutor");
const RLInstructor = artifacts.require("RLInstructor");

const COExecutor = artifacts.require("COExecutor");
const COInstructor = artifacts.require("COInstructor");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(BasicPerf, {overwrite: true}).then(async () => { }); 

  var RLExecutor_addr;
  deployer.deploy(RLExecutor, {overwrite: true}).then(async () => {
    RLExecutor_addr = RLExecutor.address; 
    await deployer.deploy(RLInstructor, RLExecutor_addr, {overwrite: true}); 
  });

  var COExecutor_addr;
  deployer.deploy(COExecutor, {overwrite: true}).then(async () => {
    COExecutor_addr = COExecutor.address; 
    await deployer.deploy(COInstructor, COExecutor_addr, {overwrite: true}); 
  });
};