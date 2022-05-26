//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./Interfaces/IAave.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Interfaces/IToken.sol";
import "hardhat/console.sol";

contract Aave {
    constructor(address _addisToken) {
        addisToken = IToken(_addisToken);
    }

    IToken private addisToken;
    IAave AAve = IAave(0x794a61358D6845594F94dc1DB02A252b5b4814aD);

    function deposit(address asset, uint256 amount) public {
        IERC20(asset).transferFrom(msg.sender, address(this), amount);
        IERC20(asset).approve(address(AAve), amount);
        AAve.supply(asset, amount, msg.sender, 0);
        addisToken.mint(msg.sender, amount);
    }
}
