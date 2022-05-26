//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract upDAI is ERC20, Ownable {
    address aave;

    constructor(address _aave) ERC20("Addis Token", "ADD") {
        aave = _aave;
    }

    modifier onlyAave() {
        require(_msgSender() == aave, "Access denied");
        _;
    }

    function mint(address _to, uint256 _amount) external onlyAave {
        _mint(_to, _amount);
    }
}
