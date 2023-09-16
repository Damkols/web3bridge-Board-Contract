import { ethers } from "hardhat";

async function main() {
 const boardDeploy = await ethers.deployContract("Board", []);
 await boardDeploy.waitForDeployment();
 console.log(boardDeploy);
 console.log(`Board deployed to ${boardDeploy.target}`);

 const boardCA = "0x578E98bF0399cDC20914f874d5Fe49fF763FAfBc";

 const BoardContract = await ethers.getContractAt("Board", boardCA);

 //    Board deployed on Goerli at 0x717a33a9EeF6d3b1BA3c7cc2D388A0e923200b03

 //   Randomize Colors
 const setRandomColors = await BoardContract.randomizeColors();

 console.log(setRandomColors);

 //getCellColor

 const getCellColor = await BoardContract.getCellColor(1, 2);

 console.log(getCellColor);

 //whiteCellCount

 const getWhiteCellCount = await BoardContract.whiteCellCount;

 console.log(getWhiteCellCount);

 //blackCellCount

 const getBlackCellCount = await BoardContract.blackCellCount;

 console.log(getBlackCellCount);

 //redCellCount

 const getRedCellCount = await BoardContract.redCellCount;

 console.log(getRedCellCount);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
 console.error(error);
 process.exitCode = 1;
});
