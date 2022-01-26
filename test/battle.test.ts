import { network, ethers } from "hardhat";
import { Signer, BigNumber, utils } from "ethers";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";



chai.use(solidity);

const createShare = async () => {
    const RevShare = await ethers.getContractFactory("RevShare");
    const revShare = await RevShare.deploy();
    await revShare.deployed();
    const [owner, ...rest] = await ethers.getSigners();
    const amount = BigNumber.from('10').pow('17');
    const duration = 100;
    const start_timestamp = (new Date().getTime() / 1000) + 1000;
    await revShare.createShare(amount, start_timestamp, duration);

}




describe("Battle NFT Factory", function () {

    it("Should create a battle, and other player join", async function () {
        const BattleNFTFactory = await ethers.getContractFactory("BattleNFTFactory");
        const Champions = await ethers.getContractFactory("CoinLeagueChampions");
        const champions = Champions.attach("0xf2a669A2749073E55c56E27C2f4EdAdb7BD8d95D");
        const battleNFTFactory = await BattleNFTFactory.deploy();
        await battleNFTFactory.deployed();
        const [owner, ...rest] = await ethers.getSigners();
        const amount = BigNumber.from('10').pow('17');
        const duration = 10;
        let  blockNumber = await ethers.provider.getBlockNumber();
        let timestamp = (await ethers.provider.getBlock(blockNumber)).timestamp;
        console.log("before timetsamp ", timestamp)
        const start_timestamp = timestamp + 100;
        console.log("before start timetsamp ", start_timestamp)
         // impersonate account with NFT's on Polygon
         await network.provider.request({
            method: "hardhat_impersonateAccount",
            params: ["0x367D8F9DBafc73560633b58b38db67CE48443B27"],
        });
        // Creates a share for Bittoken 
        const nftSigner = await ethers.getSigner(
            "0x367D8F9DBafc73560633b58b38db67CE48443B27"
        );

        await network.provider.request({
            method: "hardhat_impersonateAccount",
            params: [ "0x0df4214cbc6b1aa91d564a9af5afd289e1526e00"],
        });

         // Creates a share for Bittoken 
         const nftSigner2 = await ethers.getSigner(
            "0x0df4214cbc6b1aa91d564a9af5afd289e1526e00"
        );
            // Create a gamw with 0.1 Matic, type Bear
        // Join game with nft id 17, if it is Bittoken, it choose Bitcoin feed. Game with id 0
        await battleNFTFactory.connect(nftSigner).createAndJoinGame(17, 1, 1000, start_timestamp, duration, amount, 0, {value: amount});
        // Player2 join game created by the other players
        await battleNFTFactory.connect(nftSigner2).joinGame(0, 119, 1, 1000, {value: amount})
    
        let blocksToAdvance = 2;
        // advance till after duration
        for (let index = 0; index < blocksToAdvance; index++) {
            await network.provider.send('evm_mine');

        }
        // Start game
        await battleNFTFactory.startGame(0);
        blocksToAdvance = 10;
        // advance till timestamp
        for (let index = 0; index < blocksToAdvance; index++) {
            await network.provider.send('evm_mine');
        }
        // After duration game could be ended
        await battleNFTFactory.endGame(0);
        // After win, player can claim prize for id
        //   await battleNFTFactory.connect(nftSigner).claim(0);



    })

    it("Should create a battle, and abort if no players no joined", async function () {
        const BattleNFTFactory = await ethers.getContractFactory("BattleNFTFactory");
        const battleNFTFactory = await BattleNFTFactory.deploy();
        await battleNFTFactory.deployed();
        const amount = BigNumber.from('10').pow('17');
        const duration = 10;
        let  blockNumber = await ethers.provider.getBlockNumber();
        let timestamp = (await ethers.provider.getBlock(blockNumber)).timestamp;
        console.log("before timetsamp ", timestamp)
        const start_timestamp = timestamp + 100;
        console.log("before start timetsamp ", start_timestamp)
         // impersonate account with NFT's on Polygon
         await network.provider.request({
            method: "hardhat_impersonateAccount",
            params: ["0x367D8F9DBafc73560633b58b38db67CE48443B27"],
        });
        //"0x0df4214cbc6b1aa91d564a9af5afd289e1526e00"
        // Creates a share for Bittoken 
        const nftSigner = await ethers.getSigner(
            "0x367D8F9DBafc73560633b58b38db67CE48443B27"
        );
            // Create a gamw with 0.1 Matic, type Bear
        // Join game with nft id 17, if it is Bittoken, it choose Bitcoin feed. Game with id 0
        await battleNFTFactory.connect(nftSigner).createAndJoinGame(17, 1, 1000, start_timestamp, duration, amount, 0, {value: amount});
         // Signer abort game and withdraw at same time
        await battleNFTFactory.connect(nftSigner).abortGameAndWithraw(0);

    })


})