//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract addisToken {
    string name = "Addis token";
    string symbol = "ADD";
    mapping(address => uint256) balance;

    function mint(address _to, uint256 _amount) external {
        balance[_to] += _amount;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balance[account];
    }
}
