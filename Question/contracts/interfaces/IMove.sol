pragma solidity ^0.8.0;

import "..\libraries\SystemTypes.sol";
import "..\cores\BoardTypes.sol";

abstract contract IMove {
    function validMovesFor(SystemTypes.Position memory _position) public view returns (SystemTypes.Position[] memory);
    function discardOccupiedMoves(SystemTypes.Position[] memory _moves, BoardTypes.Piece[] memory _occupied_positions) public view returns (SystemTypes.Position[] memory) {
        mapping (uint => bool) memory isOccupied;
        for (uint i = 0; i < _occupied_positions.length; i++)
            isOccupied[_occupied_positions[i].position.X + 8 * _occupied_positions[i].position.Y] = true;
        uint count = 0;
        for (uint i = 0; i < _moves.length; i++) {
            if (!isOccupied[_moves[i].X + 8 * _moves[i].Y]) count++;
        }
        uint j = 0;
        SystemTypes.Position[] moves = new SystemTypes.Position[](count);
        for (uint i = 0; i < _moves.length && j < count; i++) {
            if (!isOccupied[_moves[i].X + 8 * _moves[i].Y]) {
                moves[j] = _moves[i];
                j++;
            }
        }
        return moves;
    }

    function isInBoundaries(uint X, uint Y) internal pure returns(bool) {
        return (X > 0 && X < 9 && Y > 0 && Y < 9);
    }
}
