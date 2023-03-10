const hre = require("hardhat");

async function main() {
  const Token = await hre.ethers.getContractFactory("token");
  const token = await Token.deploy(1000000000000);

  await token.deployed();

  const Challenge = await hre.ethers.getContractFactory("challenge");
  const challenge = await Challenge.deploy();

  await challenge.deployed();

  console.log("deployed at: " + token.address);
  console.log("deployed at: " + challenge.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
