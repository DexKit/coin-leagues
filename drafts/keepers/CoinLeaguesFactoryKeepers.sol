//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinLeagues.sol";
import "@chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 *
 * Factory that creates the games and stores a references to each game
 *
 *
 */
contract CoinLeaguesFactoryV2 is Ownable, KeeperCompatibleInterface {
    CoinLeaguesV2[] public allGames;
    CoinLeaguesV2[] public startedGames;
    CoinLeaguesV2[] public createdGames;
    CoinLeaguesV2[] public endedGames;
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
        createdGames.push(gameAddress);
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

    function checkUpkeep(bytes calldata  checkData ) external override returns (bool upkeepNeeded, bytes memory  performData ) {
      uint256 gameId;
      uint256 gameType = abi.decode(checkData, (uint256));
      if(gameType == 0){
          for (uint256 index = 0; index < createdGames.length; index++) {
            CoinLeaguesV2.Game calldata game = createdGames[index].game();
            if( block.timestamp >= game.start_timestamp && createdGames[index].totalPlayers() > 1){
                upkeepNeeded = true;
                gameId = index;
                performData = abi.encode(index, gameType);
                break;
            }   
        }  
      }
      if(gameType == 1){
          for (uint256 index = 0; index < startedGames.length; index++) {
            CoinLeaguesV2.Game calldata game = createdGames[index].game();
            if(block.timestamp >= game.start_timestamp + game.duration){
                upkeepNeeded = true;
                gameId = index;
                performData = abi.encode(index, gameType);
                break;
            }   
        }  
      }
       if(gameType == 2){
          for (uint256 index = 0; index < startedGames.length; index++) {
           CoinLeaguesV2.Game calldata game = createdGames[index].game();
           if(block.timestamp > game.abort_timestamp  && createdGames[index].totalPlayers() < 2){
                upkeepNeeded = true;
                gameId = index;
                performData = abi.encode(index, gameType);
                break;
            } 
        }  
      }
    }

    function performUpkeep(bytes calldata performData) external {
        uint256 gameType;
        uint256 gameIndex;
        (gameType, gameIndex) = abi.decode(performData, (uint256, uint256));
        if(gameType == 0){
            createdGames[gameIndex].startGame();
            startedGames.push(createdGames[gameIndex]);
            uint256 totalCreated = createdGames.length - 1;
            createdGames[gameIndex] = createdGames[totalCreated];
            createdGames.pop();
        }
        if(gameType == 1){
             startedGames[gameIndex].endGame();
             endedGames.push(startedGames[gameIndex]);
             uint256 totalStart = startedGames.length - 1;
             startedGames[gameIndex] = startedGames[totalStart];
             startedGames.pop();
        }
        if(gameType == 2){
              createdGames[gameIndex].abortGame();
              endedGames.push(createdGames[gameIndex]);
              uint256 totalStart = createdGames.length - 1;
              createdGames[gameIndex] = createdGames[totalStart];
              createdGames.pop();
        }
  
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
