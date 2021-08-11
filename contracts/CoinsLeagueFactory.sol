//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


import "hardhat/console.sol";
import "./CoinsLeague.sol";
/**
*
* Factory that creates the games and stores a reference to each game
*
* 
*/
contract CoinsLeagueFactory {
      CoinsLeague[] public coinsLeague;

      event GameCreated(address gameAddress, uint id);
      /**
       * Create game and store reference on array
       */
      function createGame(uint8 _num_players, uint256 _duration, uint256 _amount, uint8 _num_coins, uint256 _abort_timestamp) external returns (CoinsLeague gameAddress){
            CoinsLeague gameAddress = new CoinsLeague(_num_players, _duration, _amount, _num_coins, _abort_timestamp);
            coinsLeague.push(gameAddress);
            emit GameCreated(address(gameAddress), coinsLeague.length);
      }

      function totalGames() view returns(uint256){
            return coinsLeague.length;
      }

}
