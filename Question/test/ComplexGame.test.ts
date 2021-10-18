import { ethers } from "hardhat";
import { assert, expect } from "chai";
import { Contract } from "@ethersproject/contracts";


describe("Bishop", function () {
    let complexGameInstance: Contract;
    before(async function () {
        const library = await ethers.getContractFactory("Randomizer").then(e => e.deploy());
        const KnightMove = await ethers.getContractFactory("ComplexGame", {
            libraries: {
                Randomizer: library.address
            }
        });
        complexGameInstance = await KnightMove.deploy();
    });
    it('Complex Game: 10 moves', async function () {
        await complexGameInstance.setup();
        await complexGameInstance.play(10);
    });
    it('Complex Game: Two moves, new piece and ten moves', async function () {
        await complexGameInstance.setup();
        await complexGameInstance.play(2);
        const Pawn = await ethers.getContractFactory("Pawn");
        const pawnInstance = await Pawn.deploy();
        await complexGameInstance.addNewPiece(pawnInstance.address, 1, 5);
        await complexGameInstance.setup();
        await complexGameInstance.play(10);
    });
    it('Complex Game: Add a wrong piece to contract', async function () {
        await complexGameInstance.setup();
        await complexGameInstance.play(2);
        await complexGameInstance.addNewPiece(complexGameInstance.address, 1, 4);
        await complexGameInstance.setup();
        expect(await complexGameInstance.play(10).then(() => false).catch(() => true), "Add wrong piece should have failed.");
    });
});
