// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

import "./executor.sol"; 

contract RLInstructor {
    RLExecutor public executor; 

    bool storage_flip_flag; 
    uint transfer_value_1; 
    uint transfer_value_2; 

    // TODO: migrate to timed re-entrant lock or MVCC
    bool mutex;

    constructor(address _executorAddress) {
        transfer_value_1 = 1; 
        transfer_value_2 = 1; 
        storage_flip_flag = false;

        mutex = false; 

        executor = RLExecutor(_executorAddress);
    }

    function try_lock() public returns (bool) {
        if (mutex == true) {
            return false; 
        }
        mutex = true; 
        return true; 
    }

    function unlock() public {
        mutex = false; 
    }

    function flip_storage() public {
        storage_flip_flag = !storage_flip_flag; 
    }

    function get_transfer_value_primary() public view returns (uint) {
        if (storage_flip_flag == true)
        {
            return transfer_value_2;
        }
        else
        {
            return transfer_value_1; 
        }
    }

    function get_transfer_value_temp() public view returns (uint) {
        if (storage_flip_flag == true)
        {
            return transfer_value_1;
        }
        else
        {
            return transfer_value_2; 
        }
    }

    function set_transfer_value_primary(uint _transfer_value) public {
        if (storage_flip_flag == true)
        {
            transfer_value_2 = _transfer_value;
        }
        else
        {
            transfer_value_1 = _transfer_value; 
        }
    }

    function set_transfer_value_temp(uint _transfer_value) public {
        if (storage_flip_flag == true)
        {
            transfer_value_1 = _transfer_value;
        }
        else
        {
            transfer_value_2 = _transfer_value; 
        }
    }

    function update_executor(address _executorAddress) public {
        // TODO: verify proof 
        executor = RLExecutor(_executorAddress);
    }

    function double_temp_transfer_value() private {
        uint curr_transfer_value = get_transfer_value_primary();
        set_transfer_value_temp(curr_transfer_value * 2);
    }

    function begin_transaction() public {
        // lock up the mutex 
        bool is_success = try_lock();
        if (!is_success) { revert("failed to aquire lock"); }

        // double temp value 
        double_temp_transfer_value(); 
    }

    function end_transaction(bool is_success) public {
        // if success: flip storage, unlock the mutex
        // if failure: unlock the mutex
        if (is_success == true) {
            flip_storage(); 
        }
        else {
            // do nothing
        }
        unlock(); 
    }
}