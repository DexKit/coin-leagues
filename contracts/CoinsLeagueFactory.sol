//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinsLeague.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/**
 *
 * Factory that creates the games and stores a reference to each game
 *
 *
 */
contract CoinsLeagueFactory is Ownable {
    CoinsLeague[] public coinsLeague;
    address private _settings;

    event GameCreated(address gameAddress, uint256 id);
    event SettingsChanged(address settingsAddress);

    constructor(address settings) {
        _settings = settings;
    }

    /**
     * Create game and store reference on array
     */
    function createGame(
        uint8 _num_players,
        uint256 _duration,
        uint256 _amount,
        uint8 _num_coins,
        uint256 _abort_timestamp,
        CoinsLeague.GameType _game_type
    ) external returns (CoinsLeague gameAddress) {
        gameAddress = new CoinsLeague(
            _num_players,
            _duration,
            _amount,
            _num_coins,
            _abort_timestamp,
            _game_type,
            _settings
        );
        coinsLeague.push(gameAddress);
        emit GameCreated(address(gameAddress), coinsLeague.length);
    }

    function totalGames() external view returns (uint256) {
        return coinsLeague.length;
    }

    function setSettings(address newSettings) public onlyOwner(){
        require(newSettings != address(0), "Settings can not be zero address");
        _settings = newSettings;
        emit SettingsChanged(newSettings);
    }


}
