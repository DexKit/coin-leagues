// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import hre from "hardhat";
import axios from 'axios';
import ethers from 'ethers';
// example of buy kit programmatically
async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  const [...rest] = await hre.ethers.getSigners();
  
 // const amountETH = hre.ethers.utils.parseEther("1");
  // We fund all the address's
  for (let index = 0; index < 50; index++) {
    const amountETH = hre.ethers.utils.parseEther(`${(0.001*Math.random()).toFixed(5)}`);
    console.log(amountETH);
    const response = await axios.get(`https://polygon.api.0x.org/swap/v1/quote?sellAmount=${amountETH}&buyToken=0x4d0def42cf57d6f27cd4983042a55dce1c9f853c&sellToken=MATIC`)
    const json = await response.data;
    console.log(json);
    const tx = await  rest[index].sendTransaction({
      data: json.data,
      to: json.to,
      from: json.from,
      value: amountETH,
      


    });
    console.log(tx);
    //tx.wait()
  }
  
 
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
