// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../util/stack.sol";

contract NSB {
    GenericStack public revertStack;

    struct invoke_info {
        string contract_name;
        string function_name;
    }

    constructor() {
        revertStack = new GenericStack();
    }

    function push_invoke_op(invoke_info calldata data) public {
        revertStack.push(abi.encode(data));
    }

    function pop_invoke_op() public returns (invoke_info memory ii) {
        bytes memory data = revertStack.pop();
        return ii = abi.decode(data, (invoke_info));
    }
}
