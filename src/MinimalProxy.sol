// SPDX-License-Identifier: SEE LICENSE IN LICENSE

// This proxy usses deletage call to forward all calls to the implementation contract

pragma solidity ^0.8.0;
contract MinimalProxy {
    function clone(
        address implementationContract
    ) external returns (address instance) {
        assembly {
            let pointer := mload(0x40)
            mstore(pointer, 0x3d602d80600a3d3981f3)
            mstore(add(pointer, 0x14), shl(0x60, implementationContract))
            mstore(add(pointer, 0x28), 0x5af43d82803e903d91602b57fd5bf3)
            instance := create(0, pointer, 0x37)
        }
        require(
            instance != address(0),
            "MinimalProxy: Failed to create instance"
        );
    }
}
