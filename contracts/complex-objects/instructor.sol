// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

import "./co-utils.sol"; 
import "./executor.sol"; 

contract COInstructor {
    COExecutor public executor; 

    bool storage_flip_flag; 
    COUtils.ComplexObject complex_object1; 
    COUtils.ComplexObject complex_object2; 

    // TODO: migrate to timed re-entrant lock or MVCC
    bool mutex;

    constructor(address _executorAddress) {
        complex_object1.data1 = 1; 
        complex_object1.data2 = 2; 
        complex_object2.data1 = 1; 
        complex_object2.data2 = 2; 

        storage_flip_flag = false;

        mutex = false; 

        executor = COExecutor(_executorAddress);
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

    function get_transfer_value_primary() public view returns (COUtils.ComplexObject memory) {
        if (storage_flip_flag == true)
        {
            return complex_object2;
        }
        else
        {
            return complex_object1; 
        }
    }

    function get_transfer_value_temp() public view returns (COUtils.ComplexObject memory) {
        if (storage_flip_flag == true)
        {
            return complex_object1;
        }
        else
        {
            return complex_object2; 
        }
    }

    function set_transfer_value_primary(COUtils.ComplexObject memory _complex_object) public {
        if (storage_flip_flag == true)
        {
            complex_object2.data1 = _complex_object.data1;
            complex_object2.data2 = _complex_object.data2;
        }
        else
        {
            complex_object1.data1 = _complex_object.data1;
            complex_object1.data2 = _complex_object.data2;
        }
    }

    function set_transfer_value_temp(COUtils.ComplexObject memory _complex_object) public {
        if (storage_flip_flag == true)
        {
            complex_object1.data1 = _complex_object.data1;
            complex_object1.data2 = _complex_object.data2;
        }
        else
        {
            complex_object2.data1 = _complex_object.data1;
            complex_object2.data2 = _complex_object.data2;
        }
    }

    function update_executor(address _executorAddress) public {
        // TODO: verify proof 
        executor = COExecutor(_executorAddress);
    }

    function double_transfer_value() private {
        COUtils.ComplexObject memory curr_complex_object = get_transfer_value_primary();
        curr_complex_object.data1 = curr_complex_object.data1 * 2; 
        curr_complex_object.data2 = curr_complex_object.data2 * 2; 
        set_transfer_value_temp(curr_complex_object);
    }

    function begin_transaction() public {
        // lock up the mutex 
        bool is_success = try_lock();
        if (!is_success) { revert("failed to aquire lock"); }

        // double temp value 
        double_transfer_value(); 
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