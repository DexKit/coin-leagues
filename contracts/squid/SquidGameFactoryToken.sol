//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./SquidGameToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * In progress
 */
contract SquidGameFactoryToken is Ownable {
    SquidGameToken[] public allGames;
    event SquidCreated(
        address game_address,
        uint256 id,
        uint256 start_timestamp,
        uint256 pot,
        address coin_to_play
    );

    function createSquid(
        uint256 start_timestamp,
        uint256 pot,
        address coin_to_play
    ) external returns (SquidGameToken gameAddress) {
        gameAddress = new SquidGameToken(start_timestamp, pot, coin_to_play);
        allGames.push(gameAddress);

        emit SquidCreated(
            address(gameAddress),
            allGames.length - 1,
            start_timestamp,
            pot,
            coin_to_play
        );
    }

    function totalGames() external view returns (uint256) {
        return allGames.length;
    }

    function joinGame(address game) external payable {
        SquidGameToken(game).joinGame(msg.sender);
    }
}
