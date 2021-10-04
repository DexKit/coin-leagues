//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinLeagueV2.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/**
 *
 * Factory that creates the games and stores a references to each created, started, aborted and ended games
 *
 *
 */
contract CoinLeaguesFactoryV2 is Ownable {
    CoinLeaguesV2[] public allGames;
    CoinLeaguesV2[] public startedGames;
    CoinLeaguesV2[] public createdGames;
    CoinLeaguesV2[] public endedGames;
    mapping(address => uint256) startedGameMap;
    mapping(address => uint256) createdGameMap;
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
        uint256 index = allGames.length;
        gameAddress = new CoinsLeague(
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
        createdGameMap[address(gameAddress)] = createdGames.length - 1;
        emit GameCreated(address(gameAddress), allGames.length-1);
    }

    function startGame(uint256 id) external {
        allGames[id].startGame();
        startedGames.push(allGames[id]);
        startedGameMap[address(allGames[id])] = startedGames.length -1;
        uint256 gameId = createdGameMap[address(allGames[id])];
        uint256 totalCreated = createdGames.length - 1;
        createdGames[gameId] = createdGames[totalCreated];
        createdGames.pop();
    }

    function endGame(uint256 id) external {
        allGames[id].endGame();
        endedGames.push(allGames[id]);
        uint256 gameId = startedGameMap[address(allGames[id])];
        uint256 totalStart = startedGames.length - 1;
        startedGames[gameId] = startedGames[totalStart];
        startedGames.pop();
    }
    function abortGame(uint256 id) external {
        allGames[id].abortGame();
        endedGames.push(allGames[id]);
        uint256 gameId = createdGameMap[address(allGames[id])];
        uint256 totalStart = createdGames.length - 1;
        createdGames[gameId] = createdGames[totalStart];
        createdGames.pop();
    }


    function totalGames() external view returns (uint256) {
        return allGames.length;
    }

    function totalCreatedGames() external view returns (uint256) {
        return createdGames.length;
    }

    function totalStartGames() external view returns (uint256) {
        return startedGames.length;
    }

    function totalEndedGames() external view returns (uint256) {
        return endedGames.length;
    }

    function setSettings(address newSettings) public onlyOwner(){
        require(newSettings != address(0), "Settings can not be zero address");
        _settings = newSettings;
        emit SettingsChanged(newSettings);
    }


}
