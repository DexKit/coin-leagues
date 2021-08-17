import { ethers, network } from "hardhat";
import { Signer, BigNumber } from "ethers";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";
import { allCoins } from "../test/constants";


chai.use(solidity);


describe("CoinsLeagueFactory", function () {
  it("Should create a game with the Factory", async function () {
    const CoinsLeagueFactory = await ethers.getContractFactory("CoinsLeagueFactory");
    const num_players = "10";
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const num_coins = `${allCoins.length}`;

    const coinsLeagueFactory = await CoinsLeagueFactory.deploy();
    await coinsLeagueFactory.deployed();
    expect(await coinsLeagueFactory.totalGames()).to.equal(0);
    const blockNumber = await ethers.provider.getBlockNumber();
    const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 10*60;
    const coinsLeague = await coinsLeagueFactory.createGame(num_players, duration, amount, num_coins, abortDate);
    console.log(coinsLeague);
    expect(await coinsLeagueFactory.totalGames()).to.equal(1);
    console.log(await coinsLeagueFactory.coinsLeague(0));
  
  });



});
