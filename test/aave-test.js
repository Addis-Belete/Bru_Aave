const { expect } = require("chai");
const { ethers } = require("hardhat");
const Web3 = require("web3");
describe("Aave", function () {
	it("Should depsit assets to Aave protocol and returns ADD token to user", async function () {
		const WFTM = "0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83";
		const Dai = "0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E"
		const USDC = "0x04068DA6C83AFCFA0e13ba15A6696662335D5B75";
		const ADD = await ethers.getContractFactory("addisToken");
		const addisToken = await ADD.deploy();
		await addisToken.deployed();
		console.log("Addis token deployed to-->", addisToken.address);
		const Aave = await ethers.getContractFactory("Aave");
		const aave = await Aave.deploy(addisToken.address);
		await aave.deployed();
		console.log("Aave pool deployed too -->", aave.address);

		const daiWhale = "0x5d13f4bf21db713e17e04d711e0bf7eaf18540d6";
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
		const ADDToken = new ethers.Contract(
			addisToken.address,

			[
				"function balanceOf(address account) external view returns (uint256)"
			],
			signer
		)

		const aFanDai = new ethers.Contract(
			"0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE",

			[
				"function balanceOf(address account) external view returns (uint256)"
			],
			signer
		)
		const firstBal = await DAI.balanceOf(daiWhale);
		console.log("Balance diaWhale:", firstBal.toString());

		// deposit to Aave

		await DAI.connect(signer).approve(aave.address, firstBal.toString());
		await aave.connect(signer).deposit(Dai, firstBal.toString(), { gasLimit: "684853" });
		const ADDBalance = await ADDToken.balanceOf(daiWhale);
		console.log("Rewarded ADDD token -->", ADDBalance.toString());
		const userBalanceAfterDeposit = await DAI.balanceOf(daiWhale);
		expect(userBalanceAfterDeposit.toString()).to.equal("0");
		const aFanDaiBalance = await aFanDai.balanceOf(daiWhale);
		console.log("returned aFanToken From Aave-->", aFanDaiBalance.toString());


	});
});
