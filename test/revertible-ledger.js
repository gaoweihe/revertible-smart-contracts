const { Web3 } = require('web3');
const SmartContractA = artifacts.require("SmartContractA");
const SmartContractB = artifacts.require("SmartContractB");
const NSB = artifacts.require("NSB");

contract("TestRL", (accounts) => {
    it("simple call", async () => {
        let result; 
        const chainx_provider = new Web3.providers.HttpProvider('http://localhost:60545');
        const chainx_network = new Web3(chainx_provider);
        chainx_network.eth.defaultAccount = chainx_network.eth.getAccounts()[0];
        const chainy_network = new Web3(new Web3.providers.HttpProvider('http://localhost:60546'));
        const nsb_network = new Web3(new Web3.providers.HttpProvider('http://localhost:60547'));
        
        const instance = await SmartContractA.deployed(); 
        result = await instance.increase_value();
        console.log('Increased value:', result.logs[0].args.newValue.toString());
        await instance._revert(1); 
        result = await instance.get_value();
        console.log("Get value: ", result.toString()); 
    });
});
