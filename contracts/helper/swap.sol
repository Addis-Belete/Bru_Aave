//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../Interfaces/IRouter.sol";
import "hardhat/console.sol";

contract Swap {
    using SafeMath for uint256;
    ISpookyRouter spookySwapRouter =
        ISpookyRouter(0xF491e7B69E4244ad4002BC14e878a34207E38c29);

    function convert(address _tokenIn, address _tokenOut) public payable {
        require(msg.value > 0, "FTM must be greater than 0");
        address[] memory path = new address[](2);
        path[0] = _tokenIn;
        path[1] = _tokenOut;

        uint256 amountOutMin = getAmountsOut(
            _tokenIn,
            _tokenOut,
            msg.value.div(2)
        );
        console.log(amountOutMin);
        uint256 _deadline = block.timestamp + 5 minutes;
        console.log(_deadline);

        spookySwapRouter.swapExactETHForTokens{value: msg.value.div(2)}(
            amountOutMin,
            path,
            address(this),
            _deadline
        );
    }

    function getAmountsOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn
    ) public view returns (uint256) {
        address[] memory path = new address[](2);
        path[0] = _tokenIn;
        path[1] = _tokenOut;
        uint256[] memory amountOut = spookySwapRouter.getAmountsOut(
            _amountIn,
            path
        );
        return (amountOut[path.length - 1]);
    }
}
