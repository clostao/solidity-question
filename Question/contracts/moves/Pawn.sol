pragma solidity ^0.8.0;

import "../interfaces/IMove.sol";

contract Pawn is IMove {
    constructor() {}

    function validMovesFor(SystemTypes.Position memory _position) public override pure returns (SystemTypes.Position[] memory) {
        if (_position.Y < 8) {
            SystemTypes.Position[] memory result = new SystemTypes.Position[](1);
            result[0] = SystemTypes.Position(_position.X, _position.Y + 1);
            return result;
        }
        return new SystemTypes.Position[](0);
    }
}
