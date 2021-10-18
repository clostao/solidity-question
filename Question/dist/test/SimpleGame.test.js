"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
describe("SimpleGame", function () {
    let randomizerLib;
    let simpleGame;
    before(async function () {
        const Randomizer = await hardhat_1.ethers.getContractFactory("Randomizer");
        randomizerLib = await Randomizer.deploy();
        const SimpleGame = await hardhat_1.ethers.getContractFactory("SimpleGame", {
            libraries: {
                Randomizer: randomizerLib.address
            }
        });
        simpleGame = await SimpleGame.deploy();
    });
    describe("Play", () => {
        it("Play 10 moves", async function () {
            simpleGame.setup();
            simpleGame.play(10);
        });
    });
});
