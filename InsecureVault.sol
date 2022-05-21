// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

contract InsecureVault {
    mapping (address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function getVaultBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function withdrawAll() external {
        uint256 userBalance = balances[msg.sender];
        require(userBalance > 0, "Insufficient balance");

        (bool success,) = msg.sender.call{value:userBalance}("");
        require(success, "Failed to send Ether");

        balances[msg.sender] = 0;
    }
}
