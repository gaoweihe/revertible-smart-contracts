// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../util/stack.sol";
import "./interface.sol";

contract SmartContractB is RevertibleContract {
    uint value;

    constructor() {
        value = 1;
    }

    // dirty operations
    function set_value(uint original_value) public returns (uint) {
        push_snapshot();
        value = 2 * original_value;
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
}
