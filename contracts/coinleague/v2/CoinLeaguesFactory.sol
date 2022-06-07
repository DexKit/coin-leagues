//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinLeagues.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 *
 * Factory that creates the games and stores a references to each game
 *
 *
 */
contract CoinLeaguesFactoryV2 is Ownable {
    CoinLeaguesV2[] public allGames;
    address private _settings;
    bool public allow_create = true;

    event GameCreated(address gameAddress, uint256 id);
    event SettingsChanged(address settingsAddress);
    event AllowCreateChanged(bool allow);

    constructor(address settings, address owner) {
        _settings = settings;
        transferOwnership(owner);
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
        uint256 _start_timestamp,
        CoinLeaguesV2.GameType _game_type
    ) external returns (CoinLeaguesV2 gameAddress) {
        require(allow_create == true, "Game creation was stopped");
        uint256 index = allGames.length;
        gameAddress = new CoinLeaguesV2(
            _num_players,
            _duration,
            _amount,
            _num_coins,
            _abort_timestamp,
            _game_type,
            _settings,
            index,
            _start_timestamp
        );
        allGames.push(gameAddress);
        emit GameCreated(address(gameAddress), allGames.length - 1);
    }

    function startGame(CoinLeaguesV2 gameAddress) external {
        require(address(gameAddress) != address(0), "No null address");
        gameAddress.startGame();
    }

    function endGame(CoinLeaguesV2 gameAddress) external {
        require(address(gameAddress) != address(0), "No null address");
        gameAddress.endGame();
    }

    function abortGame(CoinLeaguesV2 gameAddress) external {
        require(address(gameAddress) != address(0), "No null address");
        gameAddress.abortGame();
    }

    function totalGames() external view returns (uint256) {
        return allGames.length;
    }

    function setSettings(address newSettings) public onlyOwner {
        require(newSettings != address(0), "Settings can not be zero address");
        _settings = newSettings;
        emit SettingsChanged(newSettings);
    }

    function setAllowCreate(bool _allow_create) external onlyOwner {
        allow_create = _allow_create;
        emit AllowCreateChanged(_allow_create);
    }
}
