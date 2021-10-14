pragma solidity ^0.8.0;

import "..\interfaces\IMove.sol";
import "..\libraries\KnightMove.sol";
import "..\libraries\SystemTypes.sol";
import "..\cores\BoardTypes.sol";

contract Knight is IMove, KnightMove {

    constructor() KnightMove() {}

    function validMovesFor(SystemTypes.Position memory _position, BoardTypes.Piece[] memory _occupied_positions) public view override returns (SystemTypes.Position[] memory) {
        return super.discardOccupiedMoves(super.validMovesFor(_position), _occupied_positions);
    }

}
