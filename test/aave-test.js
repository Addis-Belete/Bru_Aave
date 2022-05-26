const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Aave", function () {
	it("Should depsit assets to Aave protocol and returns ADD token to user", async function () {
		const ADD = await ethers.getContractFactory("addisToken");
		const addisToken = await ADD.deploy();
		await addisToken.deployed();
		console.log("Addis token deployed to-->", addisToken.address);
		const Aave = await ethers.getContractFactory("Aave");
		const aave = await Greeter.deploy("Hello, world!");
		await aave.deployed();
		console.log("Aave pool deployed too -->", aave.address);

	});
});
