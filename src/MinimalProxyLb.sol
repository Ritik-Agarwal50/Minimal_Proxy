// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "lib/openzeppelin-contracts/contracts/proxy/Clones.sol";

contract MinimalProxyLb {
    address public implementationContract;

    event ProxyCreated(address proxy);

    constructor(address _implementationContract) {
        implementationContract = _implementationContract;
    }

    function clone() external returns (address) {
        address proxy = Clones.clone(implementationContract);
        emit ProxyCreated(proxy);
        return proxy;
    }
}
