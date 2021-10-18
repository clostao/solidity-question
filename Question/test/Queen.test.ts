import { ethers } from "hardhat";
import { assert, expect } from "chai";
import { Contract } from "@ethersproject/contracts";


describe("Bishop", function () {
    let queen: Contract;
    before(async function () {
        const KnightMove = await ethers.getContractFactory("Queen");
        queen = await KnightMove.deploy();
    });
    it('Bishop at (4, 4)', async function () {
       let moves = await queen.functions.validMovesFor({X: 4, Y: 4});
        expect(moves[0].includes([8, 8]), "[8, 8] Must be a valid move.");
        expect(moves[0].includes([1, 7]), "[1, 7] Must be a valid move.");
        expect(moves[0].includes([7, 1]), "[8, 8] Must be a valid move.");
        expect(moves[0].includes([1, 1]), "[8, 8] Must be a valid move.");
        expect(moves[0].includes([1, 4]), "[1, 4] Must be a valid move.");
        expect(moves[0].includes([8, 4]), "[8, 4] Must be a valid move.");
        expect(moves[0].includes([4, 1]), "[4, 1] Must be a valid move.");
        expect(moves[0].includes([4, 8]), "[4, 8] Must be a valid move.");
        expect(!moves[0].includes([9, 9]), "[9, 9] Shouldn't be a valid move.");
        expect(!moves[0].includes([0, 8]), "[0, 8] Shouldn't be a valid move.");
        expect(!moves[0].includes([8, 0]), "[8, 0] Shouldn't be a valid move.");
        expect(!moves[0].includes([0, 0]), "[0, 0] Shouldn't be a valid move.");
        expect(!moves[0].includes([0, 4]), "[0, 4] Shouldn't be a valid move.");
        expect(!moves[0].includes([9, 4]), "[9, 4] Shouldn't be a valid move.");
        expect(!moves[0].includes([4, 0]), "[4, 0] Shouldn't be a valid move.");
        expect(!moves[0].includes([4, 9]), "[4, 9] Shouldn't be a valid move.");
    });
    it('Bishop at (1, 1)', async function () {
        let moves = await queen.functions.validMovesFor({X: 1, Y: 1});
        expect(moves[0].includes([2, 2]), "[2, 2] Must be a valid move.");
        expect(moves[0].includes([3, 3]), "[3, 3] Must be a valid move.");
        expect(moves[0].includes([4, 4]), "[4, 4] Must be a valid move.");
        expect(moves[0].includes([5, 5]), "[5, 5] Must be a valid move.");
        expect(moves[0].includes([6, 6]), "[6, 6] Must be a valid move.");
        expect(moves[0].includes([7, 7]), "[7, 7] Must be a valid move.");
        expect(moves[0].includes([8, 8]), "[8, 8] Must be a valid move.");
        expect(moves[0].includes([1, 8]), "[1, 8] Must be a valid move.");
        expect(moves[0].includes([8, 1]), "[8, 1] Must be a valid move.");
        expect(!moves[0].includes([0, 8]), "[0, 8] Must be a valid move.");
        expect(!moves[0].includes([8, 0]), "[8, 0] Must be a valid move.");
        expect(moves[0].length, "Moves must only be chess diagonal").be.eq(21);
    });
});
