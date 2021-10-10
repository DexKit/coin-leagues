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

  const Settings = await hre.ethers.getContractFactory("CoinLeagueSettingsMatic");
  const settings = await Settings.deploy();

  await settings.deployed();
  console.log("Settings deployed to:", settings.address);
  // We get the contract to deploy
  const Factory = await hre.ethers.getContractFactory("RoomFactory");
  const factory = await Factory.deploy(settings.address, owner.address);

  await factory.deployed();
  console.log("Factory deployed to:", factory.address);
  // Fast Room Games
  console.log("Creating the Rooms now");
  const room1 = await factory.createRoom();
  console.log("room1:", room1);
  // Daily Room Games
  const room2 = await factory.createRoom();
  console.log("room2: ", room2);
  // Weekly Room Games
  const room3 = await factory.createRoom();
  console.log("room3: ", room3);
  const room4 = await factory.createRoom();
  console.log("room4:", room4);

 
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
