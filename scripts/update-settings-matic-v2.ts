// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import hre  from "hardhat";
async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  const [owner] = await hre.ethers.getSigners();
  console.log(owner.address);

  const Settings = await hre.ethers.getContractFactory("CoinLeagueSettingsMaticNFT");
  const settings = await Settings.deploy();

  await settings.deployed();
  console.log("Settings deployed to:", settings.address);
  // We get the contract to deploy
  const Factory = await hre.ethers.getContractFactory("CoinLeaguesFactoryV2");
  const factory  = await Factory.attach('0xa17F25619A09318e24FDBFD2ec1EaAb569357520');
  const set = await factory.setSettings(settings.address);
  await set.wait();
  console.log("new settings address")

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
