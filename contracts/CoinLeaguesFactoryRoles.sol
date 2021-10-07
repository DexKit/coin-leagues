//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinLeagues.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 *
 * Factory that creates the games and stores a references to each created, started, aborted and ended games.
 *  Preparation to be used by ChainLink Keepers
 *
 *
 */
contract CoinLeaguesFactoryRoles is AccessControl {
    CoinLeagues[] public allGames;
    CoinLeagues[] public startedGames;
    CoinLeagues[] public createdGames;
    CoinLeagues[] public endedGames;
    address private _settings;
    bool public allow_create = true;

    event GameCreated(address gameAddress, uint256 id);
    event SettingsChanged(address settingsAddress);
    event AllowCreateChanged(bool allow);

    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE");

    constructor(address settings) {
        _settings = settings;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
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
        CoinLeagues.GameType _game_type
    ) external onlyRole(CREATOR_ROLE) returns (CoinLeagues gameAddress) {
        require(allow_create == true, "Game creation was stopped");
        uint256 index = allGames.length;
        gameAddress = new CoinLeagues(
            _num_players,
            _duration,
            _amount,
            _num_coins,
            _abort_timestamp,
            _game_type,
            _settings,
            index
        );
        allGames.push(gameAddress);
        createdGames.push(gameAddress);
        emit GameCreated(address(gameAddress), allGames.length - 1);
    }

    function startGame(uint256 id) external {
        require(id < createdGames.length, "Access non existed element");
        createdGames[id].startGame();
        startedGames.push(createdGames[id]);
        uint256 totalCreated = createdGames.length - 1;
        createdGames[id] = createdGames[totalCreated];
        createdGames.pop();
    }

    function endGame(uint256 id) external {
        require(id < startedGames.length, "Access non existed element");
        startedGames[id].endGame();
        endedGames.push(startedGames[id]);
        uint256 totalStart = startedGames.length - 1;
        startedGames[id] = startedGames[totalStart];
        startedGames.pop();
    }

    function abortGame(uint256 id) external {
        require(id < createdGames.length, "Access non existed element");
        createdGames[id].abortGame();
        endedGames.push(createdGames[id]);
        uint256 totalStart = createdGames.length - 1;
        createdGames[id] = createdGames[totalStart];
        createdGames.pop();
    }

    function totalGames() external view returns (uint256) {
        return allGames.length;
    }

    function totalCreatedGames() external view returns (uint256) {
        return createdGames.length;
    }

    function totalStartedGames() external view returns (uint256) {
        return startedGames.length;
    }

    function totalEndedGames() external view returns (uint256) {
        return endedGames.length;
    }

    function setSettings(address newSettings) public onlyRole(DEFAULT_ADMIN_ROLE)  {
        require(newSettings != address(0), "Settings can not be zero address");
        _settings = newSettings;
        emit SettingsChanged(newSettings);
    }

    function setAllowCreate(bool _allow_create) external onlyRole(DEFAULT_ADMIN_ROLE) {
        allow_create = _allow_create;
        emit AllowCreateChanged(_allow_create);
    }
}
