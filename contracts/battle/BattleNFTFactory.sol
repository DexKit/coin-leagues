//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IChampions.sol";

contract BattleNFTFactory is Ownable {

    IChampions internal immutable CHAMPIONS =
        IChampions(0xf2a669A2749073E55c56E27C2f4EdAdb7BD8d95D);

    address payable HOUSE = address(0);


    struct Coin {
        // Struct
        address coin_feed;
        int256 start_price;
        int256 end_price;
        int256 score;
    }

    Coin public coin_player1;
    Coin public coin_player2;

    struct Game{
       uint256 id;
       uint256 champion1;
       uint256 champion2;
       int256 multiplier_champion1;
       int256 multiplier_champion2;
       int256 champion1_score;
       int256 champion2_score;
       bool claimed;
       bool started;
       bool finished;
       bool aborted;
       bool withdrawed;
       uint256 entry;
       address player1;
       address player2;
       uint256 duration;
       uint256 start_timestamp;
       address winner;
    }

    Game[] public allGames;

    constructor(){

    }

    /**
     * Create battle and join at same time
     *
     */
    function createAndJoinGame(uint256 champion_id, uint256 bitt_feed, uint256 multiplier, uint256 start_timestamp, uint256 duration, uint256 entry) external payable{
        require(entry == msg.value, "Sent exact value");
        require(start_timestamp > block.timestamp, "require future date");
        require(CHAMPIONS.ownerOf(champion_id) == msg.sender, "You need to own this champion" );
        uint256 rarity = IChampions.getRarityOf(champion_id);
        // Bittoken can impersonate other coins
        if( rarity == 0){
            require(bitt_feed > 0 && bitt_feed < 9, "feed not supported");
            coin_player1.coin_feed = getChampionsFeed()[bitt_feed];
        }else{
             coin_player1.coin_feed = getChampionsFeed()[rarity];
        }

        uint256 id = allGames.length;
        
        allGames.push(
            Game(id, champion_id, -1, 0, 0, 0, 0, 0, false, false, false, false, entry, msg.sender, address(0), duration, start_timestamp, address(0))
        );

    }

    function joinGame(uint256 id, uint256 champion_id, uint256 bitt_feed, uint256 multiplier) external payable{
        require(id < allGames.length, "Game not exists");
        Game storage game = allGames[id];
        require(game.player2 == address(0), "game already full");
        game.player2 = msg.sender;
        require(game.entry == msg.value, "Sent exact value");
        require(game.started == false, "Game already started");
        require(CHAMPIONS.ownerOf(champion_id) == msg.sender, "You need to own this champion" );
        uint256 rarity = CHAMPIONS.getRarityOf(champion_id);
        // Bittoken can impersonate other coins
        if( rarity == 0){
            require(bitt_feed > 0 && bitt_feed < 9, "feed not supported");
            coin_player2.coin_feed = getChampionsFeed()[bitt_feed];
        }else{
            coin_player2.coin_feed = getChampionsFeed()[rarity];
        }
        
    }

    function startGame(uint256 id) external{
        require(id < allGames.length);
        Game storage game = allGames[id];
        require(game.start_timestamp > block.timestamp, "Game can not start yet");
        require(game.player2 != address(0), "game not full");
        coin_player1.start_price =  getPriceFeed(coin_player1.coin_feed);
        coin_player2.start_price =  getPriceFeed(coin_player2.coin_feed);


        game.started = true;

    }

    function endGame(uint256 id) external{
        require(id < allGames.length);
        Game storage game = allGames[id];
        require(game.started == true, "game not started");
        require(game.finished == false, "game not finished");
        require(game.start_timestamp + game.duration > block.timestamp, "duration still not elapsed");
        coin_player1.end_price =  getPriceFeed(coin_player1.coin_feed);
        coin_player2.end_price =  getPriceFeed(coin_player2.coin_feed);
        coin_player1.score = (((coin_player1.end_price - coin_player1.start_price)) / coin_player1.end_price) * game.multiplier_champion1;
        coin_player2.score = (((coin_player2.end_price - coin_player2.start_price)) / coin_player2.end_price) * game.multiplier_champion2;
        uint256 champion1 = game.champion1;
        uint256 champion2 = game.champion2;
        game.champion1_score = coin_player1.score + CHAMPIONS.getAttackOf(champion1) + CHAMPIONS.getRunOf(champion1) + CHAMPIONS.getAttackOf(champion1);
        game.champion2_score = coin_player2.score + CHAMPIONS.getAttackOf(champion2) + CHAMPIONS.getRunOf(champion2) + CHAMPIONS.getAttackOf(champion2);
        if(game.champion1_score > game.champion2_score){
            game.winner = game.player1;
        }else{
            game.winner = game.player2;
        }

        game.finished = true;
        
    }

    function claim(uint256 id) external{
        require(id < allGames.length);
        Game storage game = allGames[id];
        require(game.winner == msg.sender, "Not winner");
        require(game.claimed == false, "Already claimed");
        require(game.finished == true, "Game not finished");
        require(game.winner != address(0), "Winner not zero address");
        game.claimed = true;

        uint256 amountHouse = game.entry* 2 * (10/100);
        uint256 amountWinner = game.entry * 2 - amountHouse;

        (bool sentHouse, ) = HOUSE.call{value: amountHouse}("");
        require(sentHouse, "Failed to send Ether");
        (bool sent, ) = game.winner.call{value: amountWinner}("");
        require(sentHouse, "Failed to send Ether");

    }

    function abortGame(uint256 id) external{
         require(id < allGames.length);
         Game storage game = allGames[id];
         require(game.start == false, "Game  already started");
         require(game.aborted == false, "Game  already aborted");
         require(game.player2 == address(0), "Game  is already full");
         game.aborted = true;
    }



    function withdraw(uint256 id) external{
        Game storage game = allGames[id];
        require(game.aborted == true, "Game  not aborted");
        require(game.withdrawed == false, "Game  already withdrawed");
        game.withdrawed = true;
        (bool sent, ) = game.player1.call{value: game.entry}("");
    }
    /**
     * returns feed associated with coin
     */
    function getChampionsFeed()
        internal
        pure
        override
        returns (address[8] memory)
    {
        return [
            // Bittoken Jocker, could be anyone
            address(0),
            // BTC
            0xc907E116054Ad103354f2D350FD2514433D57F6f,
            // ETH
            0xF9680D99D6C9589e2a93a78A04A279e509205945,
            // DOT
            0xacb51F1a83922632ca02B25a8164c10748001BdE,
            // LINK,
            0xd9FFdb71EbE7496cC440152d43986Aae0AB76665,
            // UNI
            0xdf0Fb4e4F928d2dCB76f438575fDD8682386e13C,
            //ADA
            0x882554df528115a743c4537828DA8D5B58e52544,
            // DOGE
            0xbaf9327b6564454F4a3364C33eFeEf032b4b4444
        ];
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(coin_feed)
            .latestRoundData();
        return price;
    }

  
}