"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
const chai_1 = require("chai");
describe("Bishop", function () {
    let bishop;
    before(async function () {
        const KnightMove = await hardhat_1.ethers.getContractFactory("Bishop");
        bishop = await KnightMove.deploy();
    });
    it('Bishop at (4, 4)', async function () {
        let moves = await bishop.functions.validMovesFor({ X: 4, Y: 4 });
        chai_1.expect(moves[0].includes([8, 8]), "[8, 8] Must be a valid move.");
        chai_1.expect(moves[0].includes([1, 7]), "[1, 7] Must be a valid move.");
        chai_1.expect(moves[0].includes([7, 1]), "[8, 8] Must be a valid move.");
        chai_1.expect(moves[0].includes([1, 1]), "[8, 8] Must be a valid move.");
        chai_1.expect(!moves[0].includes([9, 9]), "[9, 9] Shouldn't be a valid move.");
        chai_1.expect(!moves[0].includes([0, 8]), "[0, 8] Shouldn't be a valid move.");
        chai_1.expect(!moves[0].includes([8, 0]), "[9, 9] Shouldn't be a valid move.");
        chai_1.expect(!moves[0].includes([0, 0]), "[0, 0] Shouldn't be a valid move.");
    });
    it('Bishop at (1, 1)', async function () {
        let moves = await bishop.functions.validMovesFor({ X: 1, Y: 1 });
        chai_1.expect(moves[0].includes([2, 2]), "[2, 2] Must be a valid move.");
        chai_1.expect(moves[0].includes([3, 3]), "[3, 3] Must be a valid move.");
        chai_1.expect(moves[0].includes([4, 4]), "[4, 4] Must be a valid move.");
        chai_1.expect(moves[0].includes([5, 5]), "[5, 5] Must be a valid move.");
        chai_1.expect(moves[0].includes([6, 6]), "[6, 6] Must be a valid move.");
        chai_1.expect(moves[0].includes([7, 7]), "[7, 7] Must be a valid move.");
        chai_1.expect(moves[0].includes([8, 8]), "[8, 8] Must be a valid move.");
        chai_1.expect(moves[0].length, "Moves must only be chess diagonal").be.eq(7);
    });
});
