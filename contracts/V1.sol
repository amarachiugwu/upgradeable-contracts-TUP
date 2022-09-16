//SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract V1 {
    address public implementation;
    address public owner;
    uint public x;

    function foo() external {
        x += 1;
    }

    function getData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.foo.selector);
    }
}

