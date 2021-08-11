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
const allCoins = [inchUSDFeed];
//const allCoins = [inchUSDFeed, aaveFeed, adaFeed, bnbFeed, bntFeed, btcFeed, croFeed, avaxFeed, bandFeed];


describe("CoinsLeague", function () {
  it("Should create a new Game and finish it", async function () {
    const CoinsLeague = await ethers.getContractFactory("CoinsLeague");
    const num_players = "10";
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const totalAmount =  BigNumber.from(num_players).mul(amount);
    const num_coins = `${allCoins.length}`;
   
    const coinsLeague = await CoinsLeague.deploy(num_players, duration, amount, num_coins);
    await coinsLeague.deployed();
    const [owner, addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8, addr9] = await ethers.getSigners();
    let joinedGame =  await coinsLeague.connect(owner).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr1).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr2).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr3).joinGame(allCoins,  {value: amount});
    await joinedGame.wait();
    joinedGame = await coinsLeague.connect(addr4).joinGame(allCoins,  {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr5).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr6).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr7).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr8).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    joinedGame =  await coinsLeague.connect(addr9).joinGame(allCoins, {value: amount});
    await joinedGame.wait();
    expect(await coinsLeague.totalCollected()).to.equal(totalAmount.toString());
    expect(await coinsLeague.totalPlayers()).to.equal(num_players);
    expect(await coinsLeague.gameStarted()).to.equal(false);
    const startGame =  await coinsLeague.connect(addr1).startGame();
    await startGame.wait();
    expect(await coinsLeague.gameStarted()).to.equal(true);
    // advance several blocks
    const blocksToAdvance =  5*60
    for (let index = 0; index < blocksToAdvance; index++) {
       await network.provider.send('evm_mine');
      
    }
    expect(await coinsLeague.gameFinished()).to.equal(false);
    const endGame =  await coinsLeague.connect(addr1).endGame();
    await endGame.wait();
    expect(await coinsLeague.gameFinished()).to.equal(true);
    const claimWinner =  await coinsLeague.connect(owner).claim();
    await claimWinner.wait();
    expect(coinsLeague.connect(addr5).claim()).to.be.revertedWith('You are not a winner');
    expect(coinsLeague.connect(owner).claim()).to.be.revertedWith('You already claimed');
    const players= await coinsLeague.players(0)
    console.log(players);
    const coin = await coinsLeague.coins('0xc929ad75B72593967DE83E7F7Cda0493458261D9');
    console.log(coin);
  });





});
