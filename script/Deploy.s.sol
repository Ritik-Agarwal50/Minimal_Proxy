// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Implementation.sol";
import "../src/MinimalProxy.sol";

contract DeployAndClone is Script {
    function run() external {
        // Start broadcasting transactions to the network
        string memory rpc_url = vm.envString("MAINNET_RPC_URL");
        vm.createFork(rpc_url);
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(privateKey);
        // Deploy the master contract
        Implementation implement = new Implementation();

        // Deploy the minimal proxy contract
        MinimalProxy minimalProxy = new MinimalProxy();

        // Clone the master contract using the minimal proxy
        address cloneAddress = minimalProxy.clone(address(implement));

        // Log the addresses
        console.log("Master Contract Address:", address(implement));
        console.log("Minimal Proxy Address:", address(minimalProxy));
        console.log("Clone Address:", cloneAddress);

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
