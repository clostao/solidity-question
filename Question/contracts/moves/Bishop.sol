pragma solidity ^0.8.0;

import "..\interfaces\IMove.sol";
import "..\libraries\SystemTypes.sol";

contract Bishop is IMove {

    constructor() { }

    function validMovesFor(SystemTypes.Position memory _position, SystemTypes.Position[] memory _occupied_positions) public view returns (SystemTypes.Position[] memory) {
        uint count = 0;
        for (uint i = 0; i < 8; i++) {
            if (isInBoundaries(_position.X + i, _position.Y + i)) count++;
            if (isInBoundaries(_position.X + i, _position.Y - i)) count++;
            if (isInBoundaries(_position.X - i, _position.Y + i)) count++;
            if (isInBoundaries(_position.X - i, _position.Y - i)) count++;
        }
        uint j = 0;
        SystemTypes.Position[] validMoves = SystemTypes.Position[](count);
        for (uint i = 0; i < 8; i++) {
            if (isInBoundaries(_position.X + i, _position.Y + i)) {
                validMoves[j] = SystemTypes.Position(_position.X + i, _position.X + i);
                j++;
            }
            if (isInBoundaries(_position.X + i, _position.Y - i)) {
                validMoves[j] = SystemTypes.Position(_position.X + i, _position.Y - i);
                j++;
            }
            if (isInBoundaries(_position.X - i, _position.Y + i)) {
                validMoves[j] = SystemTypes.Position(_position.X - i, _position.Y + i);
                j++;
            }
            if (isInBoundaries(_position.X - i, _position.Y - i)) {
                validMoves[j] = SystemTypes.Position(_position.X - i, _position.Y - i);
                j++;
            }
        }
        return super.discardOccupiedMoves(validMoves, _occupied_positions);
    }

}
