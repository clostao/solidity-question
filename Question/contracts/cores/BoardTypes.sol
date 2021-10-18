//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "../interfaces/IMove.sol";
import "../libraries/SystemTypes.sol";

library BoardTypes {
    struct Piece {
        IMove mobility;
        SystemTypes.Position position;
    }
}
