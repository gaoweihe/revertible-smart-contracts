// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IGenericStack {
    // // Event emitted when an object is pushed onto the stack
    // event ObjectPushed(uint id, string name);
    // // Event emitted when an object is popped from the stack
    // event ObjectPopped(uint id, string name);

    function push(bytes calldata data) external;
    function pop() external returns (bytes memory);
    function top() external view returns (bytes memory);
    function size() external view returns (uint256);
}

contract GenericStack is IGenericStack {
    bytes[] private stack;

    function push(bytes calldata data) external override {
        stack.push(data);
    }

    function pop() external override returns (bytes memory data) {
        require(stack.length > 0, "Stack Underflow");
        data = stack[stack.length - 1];
        stack.pop();
    }

    function top() external view override returns (bytes memory) {
        require(stack.length > 0, "Stack is empty");
        return stack[stack.length - 1];
    }

    function size() external view override returns (uint256) {
        return stack.length;
    }

    function empty() external view returns (bool) {
        return stack.length == 0;
    }
}
