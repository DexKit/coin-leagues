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




describe("RevShare", function () {

    it("Should create a share", async function () {
        const RevShare = await ethers.getContractFactory("RevShare");
        const revShare = await RevShare.deploy();
        await revShare.deployed();
        const [owner, ...rest] = await ethers.getSigners();
        const amount = BigNumber.from('10').pow('17');
        const duration = 100;
        const start_timestamp = Math.floor((new Date().getTime() / 1000) + 1000);
        const bittokenAddress = "0xfd0cbdDec28a93bB86B9db4A62258F5EF25fEfdE";
        await revShare.createShare(amount, start_timestamp, duration, bittokenAddress);
    })

    it("Should create a share, subscrive and sent", async function () {
        const RevShare = await ethers.getContractFactory("RevShare");
        const Bittoken = await ethers.getContractFactory("Token");
        const bittokenAddress = "0xfd0cbdDec28a93bB86B9db4A62258F5EF25fEfdE";
        const bittoken = Bittoken.attach("0xfd0cbdDec28a93bB86B9db4A62258F5EF25fEfdE");
        const revShare = await RevShare.deploy();
        await revShare.deployed();
        const [owner, ...rest] = await ethers.getSigners();
        const amount = BigNumber.from('10').pow('17');
        const duration = 10;
        let  blockNumber = await ethers.provider.getBlockNumber();
        let timestamp = (await ethers.provider.getBlock(blockNumber)).timestamp;
        console.log("before timetsamp ", timestamp)
        const start_timestamp = timestamp + 100;
        console.log("before start timetsamp ", start_timestamp)
        // Creates a share for Bittoken 
        await revShare.createShare(amount, start_timestamp, duration, bittokenAddress);
        console.log( (await revShare.shares(0)).start_timestamp.toString())
        console.log( (await revShare.shares(0)).duration.toString())
        let blocksToAdvance = 2;
        // advance till timestamp
        for (let index = 0; index < blocksToAdvance; index++) {
            await network.provider.send('evm_mine');

        }
        blockNumber = await ethers.provider.getBlockNumber();
        timestamp = (await ethers.provider.getBlock(blockNumber)).timestamp;
        console.log("atual chain timestamp", timestamp)
        console.log("start timestamp", start_timestamp)
        // impersonate account with NFT's on Polygon
        await network.provider.request({
            method: "hardhat_impersonateAccount",
            params: ["0x367D8F9DBafc73560633b58b38db67CE48443B27"],
        });
        const nftSigner = await ethers.getSigner(
            "0x367D8F9DBafc73560633b58b38db67CE48443B27"
        );
        

        // We here subscribe to the share with the NFT
        await revShare.connect(nftSigner).subscribeShare(0, [17, 15, 19]);

        await revShare.connect(nftSigner).subscribeShare(0, [17, 15, 19]);

        expect(await revShare.connect(nftSigner).getClaimsOf(0)).to.be.eq('3');
        // impersonate account with Bittoken on Polygon
        await network.provider.request({
            method: "hardhat_impersonateAccount",
            params: ["0x8823cd670b077494a7f36bb1109e92113fd19587"],
        });
        const bittokenSigner = await ethers.getSigner(
            "0x8823cd670b077494a7f36bb1109e92113fd19587"
        );
        // Transfer Bittoken amount to contract
        bittoken.connect(bittokenSigner).transfer(revShare.address, amount);

        blocksToAdvance = 20;
        // advance till timestamp
        for (let index = 0; index < blocksToAdvance; index++) {
            await network.provider.send('evm_mine');
        }
        // After subscribe period user is able to claim share
        await revShare.connect(nftSigner).claimShare(0);

    })


})