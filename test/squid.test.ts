//@ts-ignore
import { network, ethers } from "hardhat";
import { Signer, BigNumber, utils } from "ethers";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";

chai.use(solidity);

describe("Squid League", function () {
  it("Should create a squid game and several players join", async function () {
    const SquidGame = await ethers.getContractFactory("SquidGame");

    let blockNumber = await ethers.provider.getBlockNumber();
    let startTimestamp =
      (await ethers.provider.getBlock(blockNumber)).timestamp + 10;
    const amount = BigNumber.from("10").pow("17");
    const squidGame = await SquidGame.deploy(startTimestamp, amount);
    await squidGame.deployed();
    const [owner, ...rest] = await ethers.getSigners();
    let joinedGame = await squidGame.connect(owner).joinGame({ value: amount });
    await joinedGame.wait();
    for (let index = 0; index < 20; index++) {
      joinedGame = await squidGame
        .connect(rest[index])
        .joinGame({ value: amount });
      await joinedGame.wait();
    }
    expect((await squidGame.getJoinedPlayers()).toString()).to.be.eq("21");
    expect((await squidGame.getTotalPot()).toString()).to.be.eq("0");
    // We setup challenge
    let setupChallenge = await squidGame.connect(owner).setupChallenge();
    // We setup challeng
    await setupChallenge.wait();
    // Now players can play the challenge
    for (let index = 0; index < 20; index++) {
      let play = await squidGame.connect(rest[index]).playChallenge(true);
      await play.wait();
    }

    // We Start Challenge
    let blocksToAdvance = 3600;
    // advance till after duration
    for (let index = 0; index < blocksToAdvance; index++) {
      await network.provider.send("evm_mine");
    }
    // We start the challenge round 1
    let startChallenge = await squidGame.connect(owner).startChallenge();

    await startChallenge.wait();
    // We end Challenge
    for (let index = 0; index < blocksToAdvance; index++) {
      await network.provider.send("evm_mine");
    }
    // We finish the challenge round 1
    let endChallenge = await squidGame.connect(owner).finishChallenge();

    await endChallenge.wait();
    // We should be now on round 1 now
    expect((await squidGame.getCurrentRound()).toString()).to.be.eq("1");
    // Now users goes to play in next round
    // We end Challenge
    let blocksToAdvanceDay = 3600 * 24;
    for (let index = 0; index < blocksToAdvanceDay; index++) {
      await network.provider.send("evm_mine");
    }

    // This will be repeated on the next six rounds
    // We setup new challenge here
    setupChallenge = await squidGame.connect(owner).setupChallenge();
    // We setup challeng
    await setupChallenge.wait();
    for (let index = 0; index < 20; index++) {
      const result = await squidGame.getPlayerCurrentChallengeResultAtRound(
        rest[index].address,
        "0"
      );
      console.log(result);

      if (result) {
        let goNextChallenge = await squidGame
          .connect(rest[index])
          .playChallenge(true);
        await goNextChallenge.wait();
      }
    }

    console.log(await squidGame.connect(owner).getCurrentPlayers());
  });
});
