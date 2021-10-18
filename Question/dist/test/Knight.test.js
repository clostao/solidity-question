"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const hardhat_1 = require("hardhat");
const chai_1 = require("chai");
describe("Knight (Wrapped)", function () {
    let knight;
    before(async function () {
        const Knight = await hardhat_1.ethers.getContractFactory("Knight");
        const KnightMove = await hardhat_1.ethers.getContractFactory("KnightMove");
        knight = await Knight.deploy((await KnightMove.deploy()).address);
    });
    it('Knight at (3, 3)', async function () {
        let pos = { X: 3, Y: 3 };
        let moves = await knight.validMovesFor(pos);
        chai_1.assert.equal(moves.length, 8);
        moves.forEach(move => {
            var diff = Math.abs(move.X - pos.Y);
            if (diff == 1) {
                chai_1.assert.equal(2, Math.abs(move.Y - pos.Y));
            }
            else if (diff == 2) {
                chai_1.assert.equal(1, Math.abs(move.Y - pos.Y));
            }
            else {
                chai_1.expect.fail();
            }
        });
    });
    it('Bishop at (1, 1)', async function () {
        let pos = { X: 1, Y: 1 };
        let moves = await knight.validMovesFor(pos);
        chai_1.assert.equal(moves.length, 2);
        var possibles = [{ X: 2, Y: 3 }, { X: 3, Y: 2 }];
        moves.forEach(move => {
            chai_1.assert.isNotNull(possibles.find(m => m.X == move.X && m.Y == move.Y));
        });
    });
});
