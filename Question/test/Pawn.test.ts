import { ethers } from "hardhat";
import { assert, expect } from "chai";
import { Contract } from "@ethersproject/contracts";


describe("Pawn", function () {
    let pawn: Contract;
    before(async function () {
        const Pawn = await ethers.getContractFactory("Pawn");
        pawn = await Pawn.deploy();
    });
    it('Pawn at (1, 1)', async function () {
        let moves = await pawn.validMovesFor({X: 1, Y: 1});
        expect(moves.length, "Should be only one possible movement.").be.eq(1);
        expect(Number(moves[0].X), "X should be 1").be.eq(1);
        expect(Number(moves[0].Y), "Y should be 2").be.eq(2);
    });
    it('Pawn at (3, 8)', async function () {
        let moves = await pawn.validMovesFor({X: 3, Y: 8});
        expect(moves).be.deep.equal([]);
    });
});
