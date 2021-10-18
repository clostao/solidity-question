//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "../interfaces/IMove.sol";
import "../libraries/KnightMove.sol";
import "../libraries/SystemTypes.sol";
import "../cores/BoardTypes.sol";

contract Knight is IMove {

    KnightMove knight;

    constructor(KnightMove _knight) {
        knight = _knight;
    }

    function validMovesFor(SystemTypes.Position memory _position) public override view returns (SystemTypes.Position[] memory) {
        return knight.validMovesFor(_position);
    }
}
