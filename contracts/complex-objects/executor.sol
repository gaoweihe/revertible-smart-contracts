// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

import "./co-utils.sol"; 

contract COExecutor {
    COUtils.ComplexObject complex_object;  
    address receiver; 

    constructor() {
        complex_object.data1 = 1;
        complex_object.data2 = 2;  
    }

    function double_transfer_value() private {
        complex_object.data1 = complex_object.data1 * 2; 
        complex_object.data2 = complex_object.data2 * 2; 
    }

    function halve_transfer_value() private {
        complex_object.data1 = complex_object.data1 / 2; 
        complex_object.data2 = complex_object.data2 / 2; 
    }

    function get_transfer_value() public view returns (COUtils.ComplexObject memory) {
        return complex_object; 
    }

    function transfer() public payable returns (bool) {
        double_transfer_value(); 

        // transfer from accountX to accountY 

        // virtually transfer
        // can be other use cases

        // address payable payable_receiver = payable(receiver);
        // bool is_success = payable_receiver.send(transfer_value); 
        // return is_success; 

        if (complex_object.data1 >= 128 || complex_object.data2 >= 128) 
        {
            halve_transfer_value(); 
            return false; 
        }
        else 
        {
            return true; 
        }
    }
}
