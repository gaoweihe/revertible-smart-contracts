// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

import "./interface.sol";

contract SmartContractA is RevertibleContract {
    event ValueChanged(uint indexed newValue);

    uint value; 

    constructor() {
        value = 1; 
    }

    // dirty operations 
    function increase_value() public returns (uint) {
        push_snapshot();
        value = value + 1; 
        emit ValueChanged(value); 
        return value; 
    }

    function push_snapshot() private {
        bytes memory data = abi.encodePacked(value); 
        revertStack.push(data); 
    }

    function pop_snapshot() private returns (bytes memory) {
        bytes memory data = revertStack.pop(); 
        return data; 
    }

    function _revert(uint step_limit) override public returns (uint) {
        for (uint i = 0; i < step_limit; i++) {
            if (revertStack.empty()) {
                break; 
            }
            bytes memory data = pop_snapshot(); 
            uint _value = abi.decode(data, (uint)); 
            value = _value; 
        }

        return value; 
    }

    function get_value() public view returns (uint) {
        return value; 
    }
}