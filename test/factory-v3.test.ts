import {  network, ethers } from "hardhat";
import { Signer, BigNumber, utils } from "ethers";
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


describe("CoinLeagueFactoryV2", function () {
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
 /* it("Should grant and and create game with role creator", async function () {
    const Settings = await ethers.getContractFactory("CoinLeagueSettingsETH");
    const CoinLeagueFactory = await ethers.getContractFactory("CoinLeaguesFactoryRoles");
    const settings = await Settings.deploy();
    await settings.deployed();
    console.log(settings.address);
    const [owner, ...rest] = await ethers.getSigners();
    const factory = await CoinLeagueFactory.deploy(settings.address, owner.address);
    await factory.deployed();
  
   let addCreator = await factory.grantRole(utils.id('CREATOR_ROLE'), rest[1].address);
   await addCreator.wait()
 
    expect((await factory.hasRole(utils.id('CREATOR_ROLE'), rest[1].address))).to.equal(true);
    const num_players = "10";
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const totalAmount =  BigNumber.from(num_players).mul(amount);
    const num_coins = `${allCoins.length}`;
    const blockNumber = await ethers.provider.getBlockNumber();
    const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 10*60;

    expect(factory.connect(rest[2]).createGame(num_players, duration, amount, num_coins, abortDate, 0)).to.be.revertedWith(`AccessControl: account ${rest[2].address.toLowerCase()} is missing role ${utils.id('CREATOR_ROLE').toLowerCase()}`); 
    expect(factory.connect(owner).createGame(num_players, duration, amount, num_coins, abortDate, 0)).to.be.revertedWith(`AccessControl: account ${owner.address.toLowerCase()} is missing role ${utils.id('CREATOR_ROLE').toLowerCase()}`); 
    const createGame = await factory.connect(rest[1]).createGame(num_players, duration, amount, num_coins, abortDate, 0)
    await createGame.wait()
  })*/

 /* it("Should create a full Game from factory and start game and end game", async function () {
    const Settings = await ethers.getContractFactory("CoinLeagueSettingsETH");
    const CoinLeagueFactory = await ethers.getContractFactory("CoinLeaguesFactoryV2");
    const settings = await Settings.deploy();
    await settings.deployed();
    console.log(settings.address);
    const [owner, ...rest] = await ethers.getSigners();
    const factory = await CoinLeagueFactory.deploy(settings.address, owner.address);
    await factory.deployed();
    const num_players = "10";
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const totalAmount =  BigNumber.from(num_players).mul(amount);
    const num_coins = `${allCoins.length}`;
    const blockNumber = await ethers.provider.getBlockNumber();
    const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 10*60;
    const startDate = (await ethers.provider.getBlock(blockNumber)).timestamp - 100;
    await factory.createGame(num_players, duration, amount, num_coins, abortDate, startDate, 0);
    const createdGameAddress  = await factory.allGames(0);
    expect(createdGameAddress).to.be.a('string');
    const game = await ethers.getContractFactory("CoinLeaguesV2");

    const createdGame = game.attach(createdGameAddress);
  
    allCoins.pop();
    let joinedGame =  await  createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], owner.address, 500000, {value: amount});
    expect(createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], owner.address, 500000, {value: amount})).to.be.revertedWith('You Already joined');
    await joinedGame.wait();
    // We create the other 9 players now
    for (let index = 0; index < 9; index++) {
      const element = rest[index];
      const joinedGame =  await  createdGame.connect(element).joinGameWithCaptainCoin(allCoins, allCoins[0], element.address, 500000, {value: amount, gasLimit: 25000000});
      await joinedGame.wait();
    }
    console.log('players joined the game');
    expect((await  createdGame.game()).total_amount_collected).to.equal(totalAmount.toString());
    expect(await  createdGame.totalPlayers()).to.equal(num_players);
    expect((await  createdGame.game()).started).to.equal(false);
    const startGame =  await factory.connect(rest[0]).startGame(createdGame.address);
    await startGame.wait();
    expect((await createdGame.game()).started).to.equal(true);
    expect(factory.connect(rest[0]).startGame(createdGame.address)).to.be.revertedWith('Game already started');
    const blocksToAdvance =  5*60
    for (let index = 0; index < blocksToAdvance; index++) {
       await network.provider.send('evm_mine');
      
    }
    const endGame =  await factory.connect(rest[0]).endGame(createdGame.address);
    await endGame.wait();
    expect((await createdGame.game()).finished).to.equal(true);
  });*/

  /*it("Should create 10 player game with 2 players from factory and start game and end game", async function () {
    const Settings = await ethers.getContractFactory("CoinLeagueSettingsETH");
    const CoinLeagueFactory = await ethers.getContractFactory("CoinLeaguesFactoryV2");
    const settings = await Settings.deploy();
    await settings.deployed();
    console.log(settings.address);
    const [owner, ...rest] = await ethers.getSigners();
    const factory = await CoinLeagueFactory.deploy(settings.address, owner.address);
    await factory.deployed();
    const num_players = "10";
    const players_playing = '2';
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const totalAmount =  BigNumber.from(players_playing).mul(amount);
    const num_coins = `${allCoins.length}`;
    const blockNumber = await ethers.provider.getBlockNumber();
    const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 10*60;
    // it starts immediately
    const startDate = (await ethers.provider.getBlock(blockNumber)).timestamp - 1;
    await factory.createGame(num_players, duration, amount, num_coins, abortDate, startDate, 0);
    const createdGameAddress  = await factory.allGames(0);
    expect(createdGameAddress).to.be.a('string');
    const game = await ethers.getContractFactory("CoinLeaguesV2");

    const createdGame = game.attach(createdGameAddress);
   
    allCoins.pop();
    let joinedGame =  await  createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], owner.address, 500000, {value: amount});
    expect(createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], owner.address, 500000, {value: amount})).to.be.revertedWith('You Already joined');
    await joinedGame.wait();
    // We create the other 9 players now
    for (let index = 0; index < 1; index++) {
      const element = rest[index];
      const joinedGame =  await  createdGame.connect(element).joinGameWithCaptainCoin(allCoins, allCoins[0], element.address, 500000, {value: amount, gasLimit: 25000000});
      await joinedGame.wait();
    }
    expect((await  createdGame.game()).total_amount_collected).to.equal(totalAmount.toString());
    expect(await  createdGame.totalPlayers()).to.equal(players_playing);
    expect((await  createdGame.game()).started).to.equal(false);
    const startGame =  await factory.connect(rest[0]).startGame(createdGame.address);
    await startGame.wait();
    expect((await createdGame.game()).started).to.equal(true);
    const blocksToAdvance =  5*60
    for (let index = 0; index < blocksToAdvance; index++) {
       await network.provider.send('evm_mine');
      
    }
    const endGame =  await factory.connect(rest[0]).endGame(createdGame.address);
    await endGame.wait();
    expect((await createdGame.game()).finished).to.equal(true);
  });*/

  it("Should create a full Game from factory, abort and anyone able to claim", async function () {
    const Settings = await ethers.getContractFactory("CoinLeagueSettingsETH");
    const CoinLeagueFactory = await ethers.getContractFactory("CoinLeaguesFactoryV2");
    const settings = await Settings.deploy();
    await settings.deployed();
    console.log(settings.address);
    const [owner, ...rest] = await ethers.getSigners();
    const factory = await CoinLeagueFactory.deploy(settings.address, owner.address);
    await factory.deployed();
    const num_players = "10";
    const players_playing = "9";
    const duration = `${5*60}`;
    // 0.1 ETH
    const amount = BigNumber.from('10').pow('17');
    const totalAmount =  BigNumber.from(players_playing).mul(amount);
    const num_coins = `${allCoins.length}`;
    const blockNumber = await ethers.provider.getBlockNumber();
    const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 60;
    const startDate = (await ethers.provider.getBlock(blockNumber)).timestamp - 1;
    await factory.createGame(num_players, duration, amount, num_coins, abortDate, startDate, 0);
    const createdGameAddress  = await factory.allGames(0);
    expect(createdGameAddress).to.be.a('string');
    const game = await ethers.getContractFactory("CoinLeaguesV2");

    const createdGame = game.attach(createdGameAddress);
  
    allCoins.pop();
    let joinedGame =  await  createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], owner.address, 500000, {value: amount});
    expect(createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], owner.address, 500000, {value: amount})).to.be.revertedWith('You Already joined');
    await joinedGame.wait();
    // We create the other 8 players now
    for (let index = 0; index < 8; index++) {
      const element = rest[index];
      const joinedGame =  await  createdGame.connect(element).joinGameWithCaptainCoin(allCoins, allCoins[0], element.address, 500000, {value: amount, gasLimit: 25000000});
      await joinedGame.wait();
    }
    expect((await  createdGame.game()).total_amount_collected).to.equal(totalAmount.toString());
    expect(await  createdGame.totalPlayers()).to.equal(players_playing);
    expect((await  createdGame.game()).started).to.equal(false);
    const blocksToAdvance =  5*60
    for (let index = 0; index < blocksToAdvance; index++) {
      await network.provider.send('evm_mine');
     
   }

    const abortGame =  await factory.connect(rest[0]).abortGame(createdGame.address);
    await abortGame.wait();
    expect((await createdGame.game()).aborted).to.equal(true);
    const balance = await ethers.provider.getBalance(rest[1].address) as BigNumber;

    const withdrawGame =  await  createdGame.connect(owner).withdraw(rest[1].address);
    await withdrawGame.wait();
    const atualBalance = await ethers.provider.getBalance(rest[1].address);
    expect(atualBalance.toString()).to.be.equal(balance.add(amount).toString());
    

  })

 /* it("Should create a full Game from factory and start game and end game with 25 players", async function () {
     const [owner, ...rest] = await ethers.getSigners();
     const Settings = await ethers.getContractFactory("CoinLeagueSettingsETH");
     const CoinLeagueFactory = await ethers.getContractFactory("CoinLeaguesFactory");
     const settings = await Settings.connect(owner).deploy();
     await settings.deployed();
     console.log(settings.address);
     
     const factory = await CoinLeagueFactory.connect(owner).deploy(settings.address, owner.address);
     await factory.deployed();
     const num_players = "100";
     const duration = `${5*60}`;
     // 0.1 ETH
     const amount = BigNumber.from('10').pow('17');
     const totalAmount =  BigNumber.from(num_players).mul(amount);
     const num_coins = `${allCoins.length}`;
     const blockNumber = await ethers.provider.getBlockNumber();
     const abortDate = (await ethers.provider.getBlock(blockNumber)).timestamp + 10*60;
     await factory.connect(owner).createGame(num_players, duration, amount, num_coins, abortDate, 0);
     const createdGameAddress  = await factory.createdGames(0);
     expect(createdGameAddress).to.be.a('string');
     const game = await ethers.getContractFactory("CoinLeagues");
 
     const createdGame = game.attach(createdGameAddress);
    
     allCoins.pop();
     let joinedGame =  await  createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], 500000, {value: amount});
     await joinedGame.wait();
     expect(createdGame.connect(owner).joinGameWithCaptainCoin(allCoins, allCoins[0], 500000, {value: amount})).to.be.revertedWith('You Already joined');
     
     // We create the other 9 players now
     for (let index = 0; index < 99; index++) {
       const element = rest[index];
       console.log(element.address);
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
   });*/


});
