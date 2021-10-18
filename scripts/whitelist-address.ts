// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import hre  from "hardhat";

const CREATOR_ADDRESSES = [
  "0x529be61AF4FD199456A5Bc67B72CD2F2a0A3FD70",
  "0xF2b48EE89E6A31DA8F664B87581d876d527C62F5",
  "0x3DaC4cbbA58dE26d34f4CB6409D47C676D255841",
  "0x67B40b0cA9620cDec3397E9E2D212b7C317da6dd",
  "0x6E566e755D009E4C2507D470D65Bba43B348cC66",
  "0x33966674b0b5dE370630194e29D9679955A2E043",
  "0x37885951E437d9cD4349d252358d27d921f4f1F0",
  // 
  "0x186035678f02f19d311ad24EA73a08EA4cD7f01e",
  "0xD1C86EA01EE183a48C86EDAD3be357B40E106F97",
  "0x77279C13336751281Bfc20F7381475f2db7dEaC0",
  "0xCfc34220DAbd0afA999Db309d9789A463E344380"
]


async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  const [owner] = await hre.ethers.getSigners();

  // We get the contract to deploy
  const Factory = await hre.ethers.getContractFactory("CoinLeaguesFactoryRoles");
  const factory = Factory.attach("0x8fFA73bB9404c6fa01A16e0F996787bD3F4CeF66");
  let addCreator = await factory.connect(owner).grantRole(hre.ethers.utils.id('CREATOR_ROLE'), "0x367D8F9DBafc73560633b58b38db67CE48443B27");
  await addCreator.wait()

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
