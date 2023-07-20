const RLInstructor = artifacts.require("RLInstructor");
const RLExecutor = artifacts.require("RLExecutor");

contract("TestRL", (accounts) => {
    it("simple call", async () => {
        const executor = await RLExecutor.deployed();
        const instructor = await RLInstructor.deployed();

        var executor_value, instructor_value;
        executor_value = await executor.get_transfer_value.call({from: accounts[0]});
        instructor_value = await instructor.get_transfer_value_primary.call({from: accounts[0]});
        console.log("executor_value: ", executor_value);
        console.log("instructor_value: ", instructor_value);
        
        for (var i = 0; i < 10; i++) {
            await instructor.begin_transaction({from: accounts[0]}); 
            const is_success = await executor.transfer.call({from: accounts[0]});
            await executor.transfer({from: accounts[0]});
            console.log(is_success.valueOf()); 
            await instructor.end_transaction(is_success, {from: accounts[0]}); 

            executor_value = await executor.get_transfer_value.call({from: accounts[0]});
            instructor_value = await instructor.get_transfer_value_primary.call({from: accounts[0]});
            console.log("executor_value: ", executor_value);
            console.log("instructor_value: ", instructor_value);
        }
    });
});
