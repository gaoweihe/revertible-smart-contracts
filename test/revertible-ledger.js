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
        
        const SCAInstance = await SmartContractA.deployed(); 
        const SCBInstance = await SmartContractB.deployed(); 
        const NSBInstance = await NSB.deployed(); 

        // push ops to NSB first
        NSBInstance.push_invoke_op("SmartContractA", "increase_value"); 

        // ops on sc A
        result = await SCAInstance.increase_value();
        console.log('Increased value:', result.logs[0].args.newValue.toString());

        // ops on sc B 
        NSBInstance.push_invoke_op("SmartContractB", "set_value"); 
        SCBInstance.set_value(result.logs[0].args.newValue);

        // revert chain B 
        NSBInstance.pop_invoke_op(); 
        await SCBInstance._revert(1); 

        // revert chain A
        NSBInstance.pop_invoke_op(); 
        await SCAInstance._revert(1); 

        result = await SCAInstance.get_value();
        console.log("Get value: ", result.toString()); 
    });
});
