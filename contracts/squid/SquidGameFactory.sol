//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./SquidGame.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * In progress
 */
contract SquidGameFactory is Ownable {
    SquidGame[] public allGames;
    event SquidCreated(
        address game_address,
        uint256 id,
        uint256 start_timestamp,
        uint256 pot
    );

    function createSquid(uint256 start_timestamp, uint256 pot)
        external
        returns (SquidGame gameAddress)
    {
        gameAddress = new SquidGame(start_timestamp, pot);
        allGames.push(gameAddress);

        emit SquidCreated(
            address(gameAddress),
            allGames.length - 1,
            start_timestamp,
            pot
        );
    }

    function totalGames() external view returns (uint256) {
        return allGames.length;
    }
}
