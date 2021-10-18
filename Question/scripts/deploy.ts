import { ethers } from "hardhat";
const { readFile, writeFile } = require("fs").promises;

async function main() {
  const library = await ethers.getContractFactory("Randomizer").then(e => e.deploy());
  let ComplexGame = await ethers.getContractFactory("ComplexGame", {
    libraries: {
      Randomizer: library.address
    }
  });
  let SimpleGame = await ethers.getContractFactory("SimpleGame", {
    libraries: {
      Randomizer: library.address
    }
  });
  let complexInstance = await ComplexGame.deploy();
  let simpleInstance = await SimpleGame.deploy();
  let deploymentData = {
    ComplexGame: {
      address: complexInstance.address,
      transactionHash: complexInstance.deployTransaction.hash,
    },
    SimpleGame: {
      address: simpleInstance.address,
      transactionHash: simpleInstance.deployTransaction.hash,
    }
  };
  await writeFile('./contract-info.json', JSON.stringify(deploymentData));
}

async function addNewPiece() {
  let deploymentData = JSON.parse(await readFile('./contract-info.json').then(e => e.toString()));
  let Pawn = await ethers.getContractFactory('Pawn');
  let pawnInstance = await Pawn.deploy();
  let complexInstance = await ethers.getContractAt('ComplexGame', deploymentData.ComplexGame.address);
  complexInstance.addNewPiece(pawnInstance.address, 1, 5);
}
 
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
