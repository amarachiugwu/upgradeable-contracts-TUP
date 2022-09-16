//SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract SimpleProxy {
    address public implementation;
    address public owner = msg.sender;

    function setImplementation(address _imp) external {
        require(msg.sender == owner);
        implementation = _imp;
    }

    function _delegate(address imp) internal virtual {
        assembly {
            calldatacopy(0, 0, calldatasize())

            let result := delegatecall(gas(), imp, 0, calldatasize(), 0, 0)

            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    fallback() external payable {
        _delegate(implementation);
    }
}
