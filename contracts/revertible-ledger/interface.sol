// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0; 

import "../util/stack.sol";

interface IRevertibleContract {
    function _revert(uint step_limit) external returns (uint); 
}

abstract contract RevertibleContract is IRevertibleContract {
    GenericStack public revertStack; 

    constructor() {
        revertStack = new GenericStack(); 
    }
}