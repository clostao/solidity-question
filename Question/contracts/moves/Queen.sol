//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "../interfaces/IMove.sol";
import "../libraries/SystemTypes.sol";
import "../cores/BoardTypes.sol";

contract Queen is IMove {

    constructor() { }

    function validMovesFor(SystemTypes.Position memory _position) public override pure returns (SystemTypes.Position[] memory) {
        uint count = 0;
        bool stop = false;
        for (uint i = 1; i < 8 && !stop; i++) {
            stop = true;
            if (_position.X + i <= 8 && _position.Y + i <= 8) {
                stop = false;
                count++;
            }
            if (_position.Y  >i && _position.X + i <= 8) {
                stop = false;
                count++;
            }
            if (_position.X > i && _position.Y + i <= 8) {
                stop = false;
                count++;
            }
            if (_position.X > i && _position.Y > i) {
                stop = false;
                count++;
            }
            if (_position.X > i) {
                stop = false;
                count++;
            }
            if (_position.Y > i) {
                stop = false;
                count++;
            }
            if (_position.X + i <= 8) {
                stop = false;
                count++;
            }
            if (_position.Y + i <= 8) {
                stop = false;
                count++;
            }
        }
        uint j = 0;
        SystemTypes.Position[] memory validMoves = new SystemTypes.Position[](count);
        for (uint i = 1; i < 8; i++) {
            if (_position.X + i <= 8 && _position.Y + i <= 8) {
                validMoves[j] = SystemTypes.Position(_position.X + i, _position.X + i);
                j++;
            }
            if (_position.Y > i && _position.X + i <= 8) {
                validMoves[j] = SystemTypes.Position(_position.X + i, _position.Y - i);
                j++;
            }
            if (_position.X > i && _position.Y + i <= 8) {
                validMoves[j] = SystemTypes.Position(_position.X - i, _position.Y + i);
                j++;
            }
            if (_position.X > i && _position.Y > i) {
                validMoves[j] = SystemTypes.Position(_position.X - i, _position.Y - i);
                j++;
            }
            if (_position.X > i) {
                validMoves[j] = SystemTypes.Position(_position.X - i, _position.Y);
                j++;
            }
            if (_position.Y > i) {
                validMoves[j] = SystemTypes.Position(_position.X, _position.Y - i);
                j++;
            }
            if (_position.X + i <= 8) {
                validMoves[j] = SystemTypes.Position(_position.X + i, _position.Y);
                j++;
            }
            if (_position.Y + i <= 8) {
                validMoves[j] = SystemTypes.Position(_position.X, _position.Y + i);
                j++;
            }
        }
        return validMoves;
    }

}
