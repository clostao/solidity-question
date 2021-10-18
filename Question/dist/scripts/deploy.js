"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
async function main() {
    let ComplexGame = await hardhat_1.ethers.getContractFactory("ComplexGame");
    let SimpleGame = await hardhat_1.ethers.getContractFactory("SimpleGame");
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
}
async function addNewPiece() {
}
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
