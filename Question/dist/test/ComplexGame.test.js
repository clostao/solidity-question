"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
describe("Bishop", function () {
    let complexGameInstance;
    before(async function () {
        const library = await hardhat_1.ethers.getContractFactory("Randomizer").then(e => e.deploy());
        const KnightMove = await hardhat_1.ethers.getContractFactory("ComplexGame", {
            libraries: {
                Randomizer: library.address
            }
        });
        complexGameInstance = await KnightMove.deploy();
    });
    it('Complex Game: Two moves', async function () {
        await complexGameInstance.setup();
        await complexGameInstance.play(10);
    });
    it('Complex Game: Two moves', async function () {
        await complexGameInstance.setup();
        await complexGameInstance.play(2);
    });
    it('Complex Game: Two moves', async function () {
        await complexGameInstance.setup();
        await complexGameInstance.play(2);
    });
});
