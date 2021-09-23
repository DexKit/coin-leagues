import { ethers, network } from "hardhat";
import { Signer, BigNumber } from "ethers";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";


chai.use(solidity);


const inchUSDFeed = '0xc929ad75B72593967DE83E7F7Cda0493458261D9';
const aaveFeed = '0x547a514d5e3769680Ce22B2361c10Ea13619e8a9';
const adaFeed = '0xAE48c91dF1fE419994FFDa27da09D5aC69c30f55';
const bnbFeed = '0x14e613AC84a31f709eadbdF89C6CC390fDc9540A';
const bntFeed = '0x1E6cF0D433de4FE882A437ABC654F58E1e78548c';
const btcFeed = '0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c';
const croFeed = 	'0x00Cb80Cf097D9aA9A3779ad8EE7cF98437eaE050';
const avaxFeed = '0xFF3EEb22B5E3dE6e705b44749C2559d704923FD7';
const bandFeed = 	'0x919C77ACc7373D000b329c1276C76586ed2Dd19F';
const zrxFeed = '0x24D6B177CF20166cd8F55CaaFe1c745B44F6c203';
const snxFeed = '0x31f93DA9823d737b7E44bdee0DF389Fe62Fd1AcD';
const repFeed = '0x8f4e77806EFEC092A279AC6A49e129e560B4210E';
//const allCoins = [inchUSDFeed];
const allCoins = [inchUSDFeed, aaveFeed, adaFeed, bnbFeed, bntFeed, btcFeed, croFeed, avaxFeed, bandFeed];


describe("CoinsLeague", function () {
  it("Should create a new Game and finish it", async function () {
    const Settings = await ethers.getContractFactory("CoinsLeagueSettingsETH");
    const CoinsLeague = await ethers.getContractFactory("CoinsLeague");
    const num_players = "10";
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const totalAmount =  BigNumber.from(num_players).mul(amount);
    const num_coins = `${allCoins.length}`;
    const blockNumber = await ethers.provider.getBlockNumber();
    const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 10*60;
    const settings = await Settings.deploy();
    await settings.deployed();
    console.log(settings.address);
    const coinsLeague = await CoinsLeague.deploy(num_players, duration, amount, num_coins, abortDate, 0, settings.address);
    await coinsLeague.deployed();
    const [owner, ...rest] = await ethers.getSigners();
    let joinedGame =  await coinsLeague.connect(owner).joinGame(allCoins, {value: amount});
    expect(coinsLeague.connect(owner).joinGame(allCoins, {value: amount})).to.be.revertedWith('You Already joined');
    await joinedGame.wait();
    // We create the other 9 players now
    for (let index = 0; index < 9; index++) {
      const element = rest[index];
      const joinedGame =  await coinsLeague.connect(element).joinGame(allCoins, {value: amount, gasLimit: 25000000});
      await joinedGame.wait();
    }
    expect((await coinsLeague.game()).total_amount_collected).to.equal(totalAmount.toString());
    expect(await coinsLeague.totalPlayers()).to.equal(num_players);
    expect((await coinsLeague.game()).started).to.equal(false);
    const startGame =  await coinsLeague.connect(rest[0]).startGame();
    await startGame.wait();
    expect((await coinsLeague.game()).started).to.equal(true);
    // advance several blocks
    const blocksToAdvance =  5*60
    for (let index = 0; index < blocksToAdvance; index++) {
       await network.provider.send('evm_mine');
      
    }
    expect((await coinsLeague.game()).finished).to.equal(false);
    const endGame =  await coinsLeague.connect(rest[0]).endGame();
    await endGame.wait();
    expect((await coinsLeague.game()).finished).to.equal(true);
    const claimWinner =  await coinsLeague.connect(owner).claim();
    const winner = await coinsLeague.winners(owner.address);
    console.log(winner);
    await claimWinner.wait();
    expect(coinsLeague.connect(rest[4]).claim()).to.be.revertedWith('You are not a winner');
    expect(coinsLeague.connect(owner).claim()).to.be.revertedWith('You already claimed');
     const players = await coinsLeague.players(0);
    const coin1 = await coinsLeague.coins(btcFeed)
    console.log(players);
    console.log(coin1);

    /*for (let index = 0; index < allCoins.length; index++) {
      const coin = await coinsLeague.coins(allCoins[index]);
      console.log(coin);
    }*/
  
  });



});
