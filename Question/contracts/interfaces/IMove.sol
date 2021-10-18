//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "../libraries/SystemTypes.sol";
import "../cores/BoardTypes.sol";

interface IMove {
    function validMovesFor(SystemTypes.Position memory _position) external view returns (SystemTypes.Position[] memory);
}
