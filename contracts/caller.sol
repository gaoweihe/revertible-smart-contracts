// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

import "./callee.sol"; 

contract Caller {
    Callee public callee; 

    constructor(address _calleeAddress) {
        cal_count = 0; 
        value = 2; 
        callee = Callee(_calleeAddress);
    }

    uint cal_count;
    uint value; 

    function upd_callee(address _calleeAddress) public {
        // TODO: verify proof 
        callee = Callee(_calleeAddress);
    }
    
    function step() public {
        cal_count = cal_count + 1; 
        // value = callee.square(value);
    }
}