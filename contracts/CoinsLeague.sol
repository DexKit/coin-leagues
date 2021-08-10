//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/SignedSafeMath.sol";

import "hardhat/console.sol";


contract CoinsLeague {
  using SafeMath for uint256;
  using SignedSafeMath for int;
  enum GameType { Winner, Loser }
  struct Player { // Struct
        address[] coin_feeds;
        address player_address;
        int score;
  }

  struct Winner { // Struct
        uint8 place;
        address winner_address;
        int score;
        bool claimed;
  }

  struct Coin { // Struct
        address coin_feed;
        int start_price;
        int end_price;
        int score;
  }

  uint256[3] winner_prizes = [50, 30, 20];
  // When is only two players
  uint256[2] winner_prizes_two = [80, 20];
  
  mapping(address => Coin) public coins;

  mapping(address => Winner) public winners;

  mapping(address => uint256) amounts;

  // Game could be of type loser or winner
  struct Game {
      GameType game_type;
      bool started;
      bool scores_done;
      bool finished;
      bool aborted;
      uint8 num_coins;
      uint8 num_players;
      uint256 duration;
      uint256 start_timestamp;
      uint256 abort_timestamp;
      uint256 amount_to_play;
      uint256 total_amount_collected;
  }

  Player[] public players;

  Game public game;

  constructor(uint8 _num_players, uint256 _duration, uint256 _amount, uint8 _num_coins) {
    require(_num_players < 11, "Max 10 players");
    game.num_players = _num_players;
    game.duration = _duration;
    game.game_type = GameType.Winner;
    game.amount_to_play = _amount;
    game.num_coins = _num_coins;
  }
  /**
   * Player join game, sending native coin and choosing the price feed
   */
  function joinGame(address[] memory coin_feeds) external payable {
    require(players.length < game.num_players, "Game already full");
    require(game.num_coins >= coin_feeds.length, "Exceed supported coins");
    require(msg.value == game.amount_to_play, "You need to sent exactly the value of the pot"); 
    require(game.aborted == false, "Game was aborted"); 
    Player memory new_player;
    new_player.coin_feeds = coin_feeds;
    for (uint256 index = 0; index < coin_feeds.length; index++) {
      coins[coin_feeds[index]] = Coin(coin_feeds[index], 0, 0, 0);
    }
    new_player.player_address = msg.sender;
    amounts[msg.sender] = msg.value;
    game.total_amount_collected = game.total_amount_collected.add(msg.value);
    players.push(new_player);
  }

  /**
  * Called when game is aborted because not started due to not enough players and time elapsed
  *
   */
  function abortGame()  external{
    require(game.started == false, "Game started, could not be aborted anymore");
    require(players.length != game.num_players, "There is enough players for the game, could not be aborted");
    require(game.abort_timestamp > block.timestamp, "Abort timestamp not elapsed yet");
    game.aborted = true;

  }


  /**
  * When game starts we get all current prices for the coins of each player
   */
  function startGame() external {
    require(players.length == game.num_players, "Not meet min number of players");
    require(game.aborted == false, "Game was aborted"); 
    game.started = true;
    game.start_timestamp = block.timestamp;
    console.log(game.start_timestamp);
    for (uint256 index = 0; index < players.length; index++) {
      Player storage pl = players[index];
      for (uint256 ind = 0; ind <  pl.coin_feeds.length; ind++) {
         address coin_address = pl.coin_feeds[ind];
         Coin storage coin = coins[coin_address];
         coin.start_price = getPriceFeed(coin_address);
      }
    } 
  }
  /**
   * Game has ended fetch final price
   */
  function endGame() external{
    require( block.timestamp > game.start_timestamp + game.duration, "Game not ended");
    require(game.started == true, "Game needs to start first");
    require(game.finished == false, "Game needs already finished");
    game.finished = true;
    for (uint256 index = 0; index < players.length; index++) {
      Player storage pl = players[index];
      for (uint256 ind = 0; ind <  pl.coin_feeds.length; ind++) {
         address coin_address = pl.coin_feeds[ind];
         Coin storage coin = coins[coin_address];
         coin.end_price = getPriceFeed(coin_address);
         coin.score = coin.score.add(coin.end_price).sub(coin.start_price).mul(100).div(coin.end_price);
      }
    }
    computeScores();
    computeWinners();
  }
  /**
   * compute scores of all players 
   */
  function computeScores() public{
     for (uint256 index = 0; index < players.length; index++) {
      Player storage pl = players[index];
      for (uint256 ind = 0; ind <  pl.coin_feeds.length; ind++) {
         address coin_adress = pl.coin_feeds[ind];
         Coin memory coin = coins[coin_adress];
         pl.score = pl.score.add(coin.score);
      }
    }
  }
  /**
   * compute winners
   */
  function computeWinners() public{
      int score1;
      int score2;
      uint256 score1_index;
      uint256 score2_index;
      uint256 score3_index;
     for (uint256 index = 0; index < players.length; index++) {
       int score = players[index].score;
       if(game.game_type == GameType.Winner){
        if(score > score1){
          score1_index = index;
          score1 = score;
        }else if(score > score2){
          score2_index = index;
          score2 = score;
        }else {
          score3_index = index;
        }

       }else{

          if(score < score1){
          score1_index = index;
          score1 = score;
          }else if(score < score2){
            score2_index = index;
            score2 = score;
          }else {
            score3_index = index;
          }
       }
    }
    if(players.length > 2){
      winners[players[score1_index].player_address] = Winner(0, players[score1_index].player_address, players[score1_index].score, false);
      winners[players[score2_index].player_address] = Winner(1, players[score2_index].player_address, players[score2_index].score, false);
      winners[players[score3_index].player_address] = Winner(2, players[score3_index].player_address, players[score3_index].score, false);
    }else{
      winners[players[score1_index].player_address] = Winner(0, players[score1_index].player_address, players[score1_index].score, false);
      winners[players[score2_index].player_address] = Winner(1, players[score2_index].player_address, players[score2_index].score, false);
    }
  }


  function claim() external {
    require(game.finished == true, "Game not finished");
    require(winners[msg.sender].winner_address == msg.sender, "You are not a winner");
    require(winners[msg.sender].claimed == false, "You already claimed");
    winners[msg.sender].claimed = true;
    uint256 amount = game.total_amount_collected.sub(amountToHouse());
    uint256 amountSend = amount.mul(winner_prizes[winners[msg.sender].place]).div(100);

    (bool sent, bytes memory data) = msg.sender.call{value: amountSend}("");
    require(sent, "Failed to send Ether");
  }
  /**
  * house receives 10% of all amount
   */
  function houseClaim() external{
    require(game.finished == true, "Game not finished");
    address house_address = 0x0000000000000000000000000000000000000000;
    uint256 amountToHouse = game.total_amount_collected.mul(10).div(100);

    (bool sent, bytes memory data) = house_address.call{value: amountToHouse}("");
    require(sent, "Failed to send Ether");
  }

 

  function withdraw() external {
    require(game.aborted == true, "Game not aborted");
    uint256 amount = amounts[msg.sender];
    amounts[msg.sender] = 0;
    (bool sent, bytes memory data) = msg.sender.call{value: amount}("");
    require(sent, "Failed to send Ether");
  }

  
 
  
  function getPriceFeed(address coin_feed) private view returns (int){
      (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = AggregatorV3Interface(coin_feed).latestRoundData();
     return price;
  }
/**
* View Functions
 */
   function amountToHouse() public view returns(uint256){
    return game.total_amount_collected.mul(10).div(100);
  }

  function totalCollected() public view returns(uint256){
    return game.total_amount_collected;
  }

  function totalPlayers() public view returns(uint256){
    return players.length;
  }

  function gameFinished() public view returns(bool){
    return game.finished;
  }

  function gameStarted() public view returns(bool){
    return game.started;
  }

  function gameAborted() public view returns(bool){
    return game.aborted;
  }

  function gameScoredDone() public view returns(bool){
    return game.scores_done;
  }

}
