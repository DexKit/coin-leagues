//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./GameTournament.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 *
 * Factory that creates the games and stores a references to each created, started, aborted and ended games.
 *  Preparation to be used by ChainLink Keepers
 *
 *
 */
contract Tournament is Ownable {
    GameTournament[] public allGames;
    address private _settings;
    address private _creator;
    uint256 public round = 0;
    mapping(address => mapping(uint256 => bool)) public players;
    mapping(address => mapping(uint256 => bool)) public playersIn;
    mapping(uint256 => uint256) public gamesPerRound;
    mapping(uint256 => uint256) public maxGamesPerRound;
    bool public allow_create = true;

    event GameCreated(address gameAddress, uint256 id, uint256 round);
    event SettingsChanged(address settingsAddress);
    event AllowCreateChanged(bool allow);

    constructor(address settings, address owner, address creator) {
        _settings = settings;
        _creator = creator;
        transferOwnership(owner);
        maxGamesPerRound[0] = 10;
        maxGamesPerRound[1] = 3;
        maxGamesPerRound[2] = 1;
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
        GameTournament.GameType _game_type
    ) external returns (GameTournament gameAddress) {
        require(allow_create == true, "Game creation was stopped");
        
        uint256 index = allGames.length;
        gameAddress = new GameTournament(
            _num_players,
            _duration,
            _amount,
            _num_coins,
            _abort_timestamp,
            _start_timestamp,
            _game_type,
            _settings,
            index,
            round
        );
        allGames.push(gameAddress);
        gamesPerRound[round] = gamesPerRound[round] + 1;
        require(gamesPerRound[round] < maxGamesPerRound[round], "can not create more games in this round");
        
        emit GameCreated(address(gameAddress), allGames.length - 1, round);
    }

    function joinGame(
        address[] memory coin_feeds,
        address captain_coin,
        uint256 champion_id,
        GameTournament Tourn
        ) external {
        if(round == 0){
            require(playersIn[msg.sender][round] != true, "Player already joined");
            Tourn.joinGameWithCaptainCoin(coin_feeds, captain_coin, champion_id);
            playersIn[msg.sender][round] = true;
        }else{
            require(players[msg.sender][round] == true, "Player not allowed");
            Tourn.joinGameWithCaptainCoin(coin_feeds, captain_coin, champion_id);

        }
    }

   function startGame(GameTournament gameAddress) external {
        require(address(gameAddress) != address(0), "No null address");
        gameAddress.startGame();
    }

    function endGame(GameTournament gameAddress) external {
        require(address(gameAddress) != address(0), "No null address");
        gameAddress.endGame();
        address[] memory winners = gameAddress.getWinnerPlayers();
        for (uint256 index = 0; index < winners.length; index++) {
            players[winners[index]][round + 1] = true;
        }
    }

    function abortGame(GameTournament gameAddress) external {
        require(address(gameAddress) != address(0), "No null address");
        gameAddress.abortGame();
    }

    function totalGames() external view returns (uint256) {
        return allGames.length;
    }

    function advanceRound() external  {
        require(_creator == msg.sender, "only creator can advance");
        round = round + 1;
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
