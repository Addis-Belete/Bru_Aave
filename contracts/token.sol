//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract upDAI is ERC20, Ownable {
    address private dv;

    constructor() ERC20("Addis Token", "ADD") {}

    modifier onlyVault() {
        require(_msgSender() == address(dv), "Access denied");
        _;
    }

    function mint(address _to, uint256 _amount) external onlyVault {
        _mint(_to, _amount);
    }

    function setVaultAddress(address _vault) external onlyOwner {
        dv = _vault;
    }
}
