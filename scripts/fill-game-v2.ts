// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import hre from "hardhat";
import { MaticPriceFeeds } from "./constants/feeds";
async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  const [owner, ...rest] = await hre.ethers.getSigners();
 /* console.log(owner.address);
  const amountETH = hre.ethers.utils.parseEther("1");
  // We fund all the address's
  for (let index = 23; index < 49; index++) {
    console.log(rest[index].address);
    const tx = await  owner.sendTransaction({
        to: rest[index].address,
        value: amountETH,
    });
    console.log(tx);
    await tx.wait()
  }*/

  const gameId = "1";
  // how to get address from id
  const Factory = await hre.ethers.getContractFactory("CoinLeaguesFactoryV2");
  // current factory address
  const factory = await Factory.attach(
    "0xb9E4B1719b575541d008f30BbB379C66C13d2C4b"
  );

  const gameAddress = await factory.allGames(gameId);
  // We get the contract to deploy
  const Game = await hre.ethers.getContractFactory("CoinLeaguesV2");
  // factory that creates and tracks all games
  console.log(gameAddress);
  const game = await Game.attach(gameAddress);
  // Flag to not use Champions multipliers
  const disableChampionId = "500000";
  // Put here the game pot, example for 0.01 MATIC
  const gamePot = hre.ethers.utils.parseEther("0.001");
  const feeds = MaticPriceFeeds;
  // Example to join a game with 1 feed and 1 captain coin
  const joined = await game
    .connect(owner)
    .joinGameWithCaptainCoin(
      [feeds[0].address, feeds[1].address, feeds[2].address, feeds[3].address],
      feeds[1].address,
      owner.address,
      disableChampionId,
      { value: gamePot }
    );
    console.log(joined);
 // await joined.wait();

  for (let index = 0; index < 49; index++) {
    console.log(`Player ${rest[index].address} joining`);
    const joined = await game
      .connect(rest[index])
      .joinGameWithCaptainCoin(
        [feeds[index+ 4].address, feeds[index + 5].address, feeds[index + 6].address, feeds[index + 7].address],
        feeds[index + 8].address,
        rest[index].address,
        disableChampionId,
        { value: gamePot }
      );
      console.log(joined);
    // joined.wait();
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
