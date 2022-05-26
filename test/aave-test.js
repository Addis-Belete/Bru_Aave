const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Aave", function () {
	it("Should depsit assets to Aave protocol and returns ADD token to user", async function () {
		const WFTM = "";
		const Dai = "0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E"
		const ADD = await ethers.getContractFactory("addisToken");
		const addisToken = await ADD.deploy();
		await addisToken.deployed();
		console.log("Addis token deployed to-->", addisToken.address);
		const Aave = await ethers.getContractFactory("Aave");
		const aave = await Aave.deploy(addisToken.address);
		await aave.deployed();
		console.log("Aave pool deployed too -->", aave.address);
		const Swap = await ethers.getContractFactory("Swap");
		const swap = await Swap.deploy();
		await swap.deployed();
		const daiWhale = "0x32276A3a773A06B97815338DfF6bcBcFD6bB4856";
		await hre.network.provider.request({
			method: "hardhat_impersonateAccount",
			params: [daiWhale],
		});

		const signer = await ethers.getSigner(daiWhale);
		const DAI = new ethers.Contract(
			Dai,
			[
				"function approve(address spender, uint256 amount) external returns (bool)",
				"function balanceOf(address account) external view returns(uint256)"
			], signer);

		// swap fantom to dia;
		await swap.convert()
		const firstBal = await DAI.balanceOf(daiWhale);
		console.log("Balance0:", ethers.utils.formatUnits(firstBal));

	});
});
