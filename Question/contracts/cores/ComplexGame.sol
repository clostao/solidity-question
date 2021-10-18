//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/IGame.sol";
import "../interfaces/IMove.sol";
import "../libraries/SystemTypes.sol";
import "../libraries/Randomizer.sol";
import "../libraries/KnightMove.sol";
import "./BoardTypes.sol";
import "../moves/Bishop.sol";
import "../moves/Knight.sol";
import "../moves/Queen.sol";
import "hardhat/console.sol";

contract ComplexGame is IGame {

    constructor () {
        predefined_pieces.push(BoardTypes.Piece(IMove(new Knight(new KnightMove())), SystemTypes.Position(1, 1)));
        predefined_pieces.push(BoardTypes.Piece(IMove(new Bishop()), SystemTypes.Position(1, 2)));
        predefined_pieces.push(BoardTypes.Piece(IMove(new Queen()), SystemTypes.Position(1, 3)));
    }

    BoardTypes.Piece[] predefined_pieces;
    BoardTypes.Piece[] pieces;
    mapping (uint => mapping (uint => bool)) occupied_positions;

    function play(uint256 _moves) override external {
         uint IMPOSSIBLE_POSITION = 9; // Avoiding magic numbers
         for (uint256 i = 0; i < _moves; i++) {
             uint indexPosition = Randomizer.random(pieces.length + i) % pieces.length; // more random since pieces length doesn't vary as much as valid moves
             SystemTypes.Position memory pos = SystemTypes.Position(IMPOSSIBLE_POSITION, IMPOSSIBLE_POSITION);
             for (uint j = 0; j < pieces.length && pos.X == IMPOSSIBLE_POSITION; j++) {
                 SystemTypes.Position[] memory moves = pieces[indexPosition].mobility.validMovesFor(pieces[indexPosition].position);
                 if (moves.length == 0) {
                     indexPosition = (indexPosition + 1) % pieces.length;
                     continue;
                 }
                 uint indexMove = Randomizer.random(moves.length) % moves.length;
                 for (uint k = 0; k < moves.length && pos.X == IMPOSSIBLE_POSITION; k++) {
                     if (!occupied_positions[moves[indexMove].Y][moves[indexMove].X]) {
                        pos = SystemTypes.Position(moves[indexMove].X, moves[indexMove].Y);
                     }
                     indexMove = (indexMove + 1) % moves.length;
                 }
                 indexPosition = (indexPosition + 1) % pieces.length;
             }
             indexPosition = (indexPosition == 0) ? (pieces.length - 1) : (indexPosition - 1);
             require(pos.X != IMPOSSIBLE_POSITION, "There are no possible movements.");
             occupied_positions[pieces[indexPosition].position.Y][pieces[indexPosition].position.X] = false;
             pieces[indexPosition].position = pos;
             occupied_positions[pieces[indexPosition].position.Y][pieces[indexPosition].position.X] = true;
             console.log("Piece with index: %d", indexPosition);
             //console.log("Piece with index %d is (%d,%d)", 0, pieces[0].position.X, pieces[0].position.Y);
             //console.log("Piece with index %d is (%d,%d)", 1, pieces[1].position.X, pieces[1].position.Y);
             //console.log("Piece with index %d is (%d,%d)", 2, pieces[2].position.X, pieces[2].position.Y);
         }
    }
    
    function setup() override external {
        pieces=predefined_pieces;
        for (uint i = 0; i < pieces.length; i++) {
            occupied_positions[pieces[i].position.X][pieces[i].position.Y] = true;
        }
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