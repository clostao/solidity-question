//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/IGame.sol";
import "..\interfaces\IMove.sol";
import "../libraries/SystemTypes.sol";
import "../libraries/Randomizer.sol";
import "../moves/Knight.sol";
import "hardhat/console.sol";

contract ComplexGame is IGame {

    constructor () {
        predefined_pieces.push(IMove(new Knight()), SystemTypes.Position(1, 1));
        predefined_pieces.push(IMove(new Bishop()), SystemTypes.Position(1, 2));
        predefined_pieces.push(IMove(new KnightMove()), SystemTypes.Position(1, 3));
    }

    BoardTypes.Piece[] predefined_pieces;
    BoardTypes.Piece[] pieces;

    function play(uint256 _moves) override external { 
         for (uint256 i = 0; i < _moves; i++) {
             uint indexPosition = Randomizer.random(positions.length);
             SystemTypes.Position[] moves = pieces[indexPosition].mobility.validMovesFor(pieces[indexPosition].position, pieces);
         }
    }
    
    function setup() override external {
        pieces=predefined_pieces;
    }

    function addNewPiece(address pieceMobilityAddress, uint X, uint Y) external {
        require(X > 0 && X < 9, "Component X should be in the integer range [1, 8].");
        require(Y > 0 && Y < 9, "Component Y should be in the integer range [1, 8].");
        for (uint  i = 0; i < predefined_pieces.length; i++) {
            require(predefined_pieces[i].position.X != X || predefined_pieces[i].position.Y != Y, "There is already a piece in that position.");
        }
        predefined_pieces.push(BoardTypes.Piece(IMove(pieceMobilityAddress), SystemTypes.Position(X, Y)));
    }
} 