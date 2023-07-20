// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract RLExecutor {
    uint transfer_value; 
    address receiver; 

    constructor() {
        transfer_value = 1; 
    }

    function double_transfer_value() private {
        transfer_value = transfer_value * 2; 
    }

    function halve_transfer_value() private {
        transfer_value = transfer_value / 2;
    }

    function get_transfer_value() public view returns (uint) {
        return transfer_value; 
    }

    function transfer() public payable returns (bool) {
        double_transfer_value(); 

        // transfer from accountX to accountY 

        // virtually transfer
        // can be other use cases

        // address payable payable_receiver = payable(receiver);
        // bool is_success = payable_receiver.send(transfer_value); 
        // return is_success; 

        if (transfer_value >= 128) 
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