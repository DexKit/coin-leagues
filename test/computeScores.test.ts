import { ethers, network } from "hardhat";
import { Signer, BigNumber } from "ethers";
import chai, { expect } from "chai";
import { solidity } from "ethereum-waffle";



chai.use(solidity);


describe("ComputeScores", function () {
  it("Should compute winners accordingly on bull game", async function () {
    const Winner = await ethers.getContractFactory("ComputeWinners");
    const winner = await Winner.deploy();
    await winner.deployed();
    console.log(winner.address);
    const [owner, ...rest] = await ethers.getSigners();
    let playerPush; 
    playerPush = await winner.connect(owner).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 15);
    await playerPush.wait();
    playerPush = await winner.connect(rest[0]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 17);
    await playerPush.wait()
    playerPush = await winner.connect(rest[1]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 18);
    await playerPush.wait()
    playerPush = await winner.connect(rest[2]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 27);
    await playerPush.wait()
    playerPush = await winner.connect(rest[3]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 26);
    await playerPush.wait()
    playerPush = await winner.connect(rest[4]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 30);
    await playerPush.wait()
    playerPush = await winner.connect(rest[5]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 31);
    await playerPush.wait()
    playerPush = await winner.connect(rest[6]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 33);
    await playerPush.wait()
    playerPush = await winner.connect(rest[7]).pushPlayers(['0xc929ad75B72593967DE83E7F7Cda0493458261D9'],'0xc929ad75B72593967DE83E7F7Cda0493458261D9', 0, 34);
    await playerPush.wait()
    const setGame =  await winner.setGame(1);
    await setGame.wait()
    const computeWinners = await winner.computeWinners();
    await computeWinners.wait();
    console.log('Getting players');
    const player = await winner.players(2);
    console.log(player);
    console.log(await  winner.winners(owner.address))
    console.log(await  winner.winners(rest[0].address))
    console.log(await  winner.winners(rest[1].address))

    expect( (await  winner.winners(owner.address)).place.toString()   ).to.equal('0');
    expect( (await  winner.winners(rest[0].address)).place.toString()   ).to.equal('1');
    expect( (await  winner.winners(rest[1].address)).place.toString()   ).to.equal('2');
   // expect( (await  winner.winners(rest[2].address)).place.toString()   ).to.equal('0');
   // expect( (await  winner.winners(rest[3].address)).place.toString()   ).to.equal('0');

    expect( (await  winner.winners(owner.address)).score.toString()   ).to.equal('15');
    expect( (await  winner.winners(rest[0].address)).score.toString()   ).to.equal('17');
    expect( (await  winner.winners(rest[1].address)).score.toString()   ).to.equal('18');
  })
  
});
