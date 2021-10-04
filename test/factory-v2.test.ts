import { ethers, network } from "hardhat";
import { Signer, BigNumber } from "ethers";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";
import { type } from "os";


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


describe("CoinLeagueFactory", function () {
 /*- let factory;
  let settings;
  beforeEach(async function(){
    const Settings = await ethers.getContractFactory("CoinLeagueSettingsETH");
    const CoinLeagueFactory = await ethers.getContractFactory("CoinLeaguesFactory");
    settings = await Settings.deploy();
    await settings.deployed();
    console.log(settings.address);
    factory = await CoinLeagueFactory.deploy(settings.address);
    await factory.deployed();

  })*/


  it("Should create a full Game from factory and start game and end game", async function () {
    const Settings = await ethers.getContractFactory("CoinLeagueSettingsETH");
    const CoinLeagueFactory = await ethers.getContractFactory("CoinLeaguesFactory");
    const settings = await Settings.deploy();
    await settings.deployed();
    console.log(settings.address);
    const factory = await CoinLeagueFactory.deploy(settings.address);
    await factory.deployed();
    const num_players = "10";
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const totalAmount =  BigNumber.from(num_players).mul(amount);
    const num_coins = `${allCoins.length}`;
    const blockNumber = await ethers.provider.getBlockNumber();
    const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 10*60;
    await factory.createGame(num_players, duration, amount, num_coins, abortDate, 0);
    const createdGameAddress  = await factory.createdGames(0);
    expect(createdGameAddress).to.be.a('string');
    const game = await ethers.getContractFactory("CoinLeagues");

    const createdGame = game.attach(createdGameAddress);
    const [owner, ...rest] = await ethers.getSigners();
    allCoins.pop();
    let joinedGame =  await  createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], 500000, {value: amount});
    expect(createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], 500000, {value: amount})).to.be.revertedWith('You Already joined');
    await joinedGame.wait();
    // We create the other 9 players now
    for (let index = 0; index < 9; index++) {
      const element = rest[index];
      const joinedGame =  await  createdGame.connect(element).joinGameWithCaptainCoin(allCoins, allCoins[0], 500000, {value: amount, gasLimit: 25000000});
      await joinedGame.wait();
    }
    expect((await  createdGame.game()).total_amount_collected).to.equal(totalAmount.toString());
    expect(await  createdGame.totalPlayers()).to.equal(num_players);
    expect((await  createdGame.game()).started).to.equal(false);
    const startGame =  await factory.connect(rest[0]).startGame(0);
    await startGame.wait();
    expect((await createdGame.game()).started).to.equal(true);
    const blocksToAdvance =  5*60
    for (let index = 0; index < blocksToAdvance; index++) {
       await network.provider.send('evm_mine');
      
    }
    const endGame =  await factory.connect(rest[0]).endGame(0);
    await endGame.wait();
    expect((await createdGame.game()).finished).to.equal(true);
  });



});
