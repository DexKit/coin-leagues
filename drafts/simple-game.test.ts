import { ethers} from "hardhat";
import {  BigNumber, Contract } from "ethers";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";
import { allCoins } from "../test/constants";



chai.use(solidity);

let coinsLeague: Contract;
const num_players = "10";
const duration = `${5*60}`;
// 0.1 ETH
const amount = BigNumber.from('10').pow('17');
const totalAmount =  BigNumber.from(num_players).mul(amount);
const num_coins = `${allCoins.length}`;   

describe("CoinsLeague", async function () {
 
    before(async ()=> {
        const CoinsLeague = await ethers.getContractFactory("CoinsLeague");   
        coinsLeague = await CoinsLeague.deploy(num_players, duration, amount, num_coins);
        await coinsLeague.deployed();
    })



    it("User can withdraw if game was aborted", async function () {

    })
  
    it("Winner can not claim twice", async function () {
    })
  
    it("House receives correct amount", async function () {

    })
  
    it("User can not enter game without minimal amount of coin feeds ", async function () {

    })
  
    it("User can not enter game without sending amount ", async function () {
      const num_players = "10";
      const duration = `${5*60}`;
      // 0.1 ETH
      const amount = BigNumber.from('10').pow('17');
      const totalAmount =  BigNumber.from(num_players).mul(amount);
      const num_coins = `${allCoins.length}`;
      const CoinsLeague = await ethers.getContractFactory("CoinsLeague");
      const coinsLeague = await CoinsLeague.deploy(num_players, duration, amount, num_coins);
      const [owner] = await ethers.getSigners();
      expect(coinsLeague.connect(owner).joinGame(allCoins)).to.be.revertedWith('You are not a winner');
  
    })

})