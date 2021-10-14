pragma solidity ^0.8.0;

import "..\interfaces\IMove.sol";

contract Queen is IMove {

    constructor() { }

    function validMovesFor(SystemTypes.Position memory _position, SystemTypes.Position[] memory _occupied_positions) public view override returns (SystemTypes.Position[] memory) {
        return SystemTypes.Position(0);
    }

}
