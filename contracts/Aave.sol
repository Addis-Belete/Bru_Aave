//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./interfaces/IAave.sol";
import "./interfaces/IERC.sol";
import "hardhat/console.sol";

contract Aave {
    constructor(address _addisToken) {
        addisToken = IERC(_addisToken);
    }

    IERC private addisToken;

    IAave AAve = IAave(0x794a61358D6845594F94dc1DB02A252b5b4814aD);

    function deposit(address asset, uint256 amount) public payable {
        IERC20(asset).approve(
            0x794a61358D6845594F94dc1DB02A252b5b4814aD,
            amount
        );
        AAve.supply(asset, amount, msg.sender, 0);
        addisToken.mint(msg.sender, amount);
    }
}
