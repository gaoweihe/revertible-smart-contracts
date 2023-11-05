const NSB = artifacts.require("NSB");

module.exports = function(deployer) {
  // deployment steps
  var NSB_addr;
  deployer.deploy(NSB, {overwrite: true}).then(async () => {
    NSB_addr = NSB.address; 
  });
};