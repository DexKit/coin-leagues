//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/SignedSafeMath.sol";
import "./interfaces/ICoinLeagueSettings.sol";

contract CoinLeague {
    using SafeMath for uint256;
    using SignedSafeMath for int256;
    enum GameType {
        Winner,
        Loser
    }

    event JoinedGame(address playerAddress);
    event StartedGame(uint256 timestamp);
    event EndedGame(uint256 timestamp);
    event AbortedGame(uint256 timestamp);
    event HouseClaimed();
    event Claimed(address playerAddress, uint place);

    struct Player {
        // Struct
        address[] coin_feeds;
        address player_address;
        int256 score;
    }

    struct Winner {
        // Struct
        uint8 place;
        address winner_address;
        int256 score;
        bool claimed;
    }

    struct Coin {
        // Struct
        address coin_feed;
        int256 start_price;
        int256 end_price;
        int256 score;
    }

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
        uint256 num_coins;
        uint256 num_players;
        uint256 duration;
        uint256 start_timestamp;
        uint256 abort_timestamp;
        uint256 amount_to_play;
        uint256 total_amount_collected;
        address settings;
    }
    bool houseClaimed = false;

    Player[] public players;

    Game public game;

    constructor(
        uint256 _num_players,
        uint256 _duration,
        uint256 _amount,
        uint256 _num_coins,
        uint256 _abort_timestamp,
        GameType _game_type,
        address  _settingsAddress
    ) {
        game.settings = _settingsAddress;
        require(ICoinsLeagueSettings(game.settings).isAllowedAmountPlayers(_num_players), "Amount of players not supported");
        require(ICoinsLeagueSettings(game.settings).isAllowedAmountCoins(_num_coins), "Amount of coins not supported");
        require(_abort_timestamp > block.timestamp, "Future date is required");
        require(ICoinsLeagueSettings(game.settings).isAllowedAmounts(_amount), "Amount not supported");
        require(ICoinsLeagueSettings(game.settings).isAllowedTimeFrame(_duration), "Time Frame not supported");
        require( _game_type == GameType.Winner || _game_type == GameType.Loser, "Game type not supported");
       
        game.num_players = _num_players;
        game.duration = _duration;
        game.game_type = _game_type;
        game.amount_to_play = _amount;
        game.num_coins = _num_coins;
        game.abort_timestamp = _abort_timestamp;
      
    }

    /**
     * Player join game, sending native coin and choosing the price feed
     * TODO: On production use the require for the validation if price feed exists
     */
    function joinGame(address[] memory coin_feeds) external payable {
        require(players.length < game.num_players, "Game already full");
        require(game.num_coins >= coin_feeds.length, "Exceed supported coins");
        require(
            msg.value == game.amount_to_play,
            "You need to sent exactly the value of the pot"
        );
        require(game.aborted == false, "Game was aborted");
        require(amounts[msg.sender] == 0, "You Already joined");
        Player storage new_player;
        new_player.coin_feeds = coin_feeds;
        for (uint256 index = 0; index < coin_feeds.length; index++) {
            require(ICoinsLeagueSettings(game.settings).isChainLinkFeed(coin_feeds[index]), "Feed not supported");
            // We create a reference to all coins to easily retrieve a feed later
            coins[coin_feeds[index]] = Coin(coin_feeds[index], 0, 0, 0);
        }
        new_player.player_address = msg.sender;
        amounts[msg.sender] = msg.value;
        game.total_amount_collected = game.total_amount_collected.add(
            msg.value
        );
        players.push(new_player);
        emit JoinedGame(msg.sender);
    }

    /**
     * Called when game is aborted because not started due to not enough players and time elapsed
     *
     */
    function abortGame() external {
        require(
            game.started == false,
            "Game started, could not be aborted anymore"
        );
        require(
            players.length != game.num_players,
            "There is enough players for the game, could not be aborted"
        );
        require(
            game.abort_timestamp > block.timestamp,
            "Abort timestamp not elapsed yet"
        );
        game.aborted = true;
        emit AbortedGame(block.timestamp);
    }

    /**
     * When game starts we get all current prices for the coins of each player
     */
    function startGame() external {
        require(
            players.length == game.num_players,
            "Not meet min number of players"
        );
        require(game.aborted == false, "Game was aborted");
        game.started = true;
        game.start_timestamp = block.timestamp;
        for (uint256 index = 0; index < players.length; index++) {
            Player storage pl = players[index];
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_address = pl.coin_feeds[ind];
                Coin storage coin = coins[coin_address];
                coin.start_price = getPriceFeed(coin_address);
            }
        }
        emit StartedGame(block.timestamp);
    }

    /**
     * Game has ended fetch final price
     */
    function endGame() external {
        require(
            block.timestamp >= game.start_timestamp + game.duration,
            "Game not ended"
        );
        require(game.started == true, "Game needs to start first");
        require(game.finished == false, "Game needs already finished");
        game.finished = true;
        for (uint256 index = 0; index < players.length; index++) {
            Player storage pl = players[index];
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_address = pl.coin_feeds[ind];
                Coin storage coin = coins[coin_address];
                coin.end_price = getPriceFeed(coin_address);
                coin.score =
                    ((coin.end_price - coin.start_price)*1000) /
                    coin.end_price;
            }
        }
        // Computes scores of game
        for(uint256 index = 0; index < players.length; index++) {
            Player storage pl = players[index];
            pl.score = 0;
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_adress = pl.coin_feeds[ind];
                Coin memory coin = coins[coin_adress];
                pl.score = pl.score + coin.score;
            }
        }

        _computeWinners();
        emit EndedGame(block.timestamp);
    }

  
    /**
     * compute winners
     */
    function _computeWinners() private {
        int256 score1;
        int256 score2;
        int256 score3;
        if (game.game_type == GameType.Winner) {
            score1 = -10000000;
            score2 = -10000000;
            score3 = -10000000;
        }else{
            score1 = 10000000;
            score2 = 10000000;
            score3 = 10000000;
        }
        uint256 score1_index = 0;
        uint256 score2_index = 0;
        uint256 score3_index = 0;
        for (uint256 index = 0; index < players.length; index++) {
            int256 score = players[index].score;
            if (game.game_type == GameType.Winner) {
                if (score > score1) {
                    score1_index = index;
                    score1 = score;
                } else if (score > score2) {
                    score2_index = index;
                    score2 = score;
                } else if (score > score3) {
                    score3 = score;
                    score3_index = index;
                }
            } else {
                if (score < score1) {
                    score1_index = index;
                    score1 = score;
                } else if (score < score2) {
                    score2_index = index;
                    score2 = score;
                } else if (score > score3) {
                    score3 = score;
                    score3_index = index;
                }
            }
        }
        if (players.length > 2) {
            winners[players[score1_index].player_address] = Winner({
                place: 0,
                winner_address: players[score1_index].player_address,
                score: players[score1_index].score,
                claimed: false
            });
            winners[players[score2_index].player_address] = Winner({
                place: 1,
                winner_address: players[score2_index].player_address,
                score: players[score2_index].score,
                claimed: false
            });
            winners[players[score3_index].player_address] = Winner({
                place: 2,
                winner_address: players[score3_index].player_address,
                score: players[score3_index].score,
                claimed: false
            });
        } else {
            winners[players[score1_index].player_address] = Winner({
                place: 0,
                winner_address: players[score1_index].player_address,
                score: score1,
                claimed: false
            });
        }
    }
    function claim() external {
        require(game.finished == true, "Game not finished");
        require(
            winners[msg.sender].winner_address == msg.sender,
            "You are not a winner"
        );
        require(winners[msg.sender].claimed == false, "You already claimed");
        winners[msg.sender].claimed = true;
        uint256 amount = game.total_amount_collected - amountToHouse();
        uint256 amountSend;
         if (players.length > 2) {
            amountSend = (amount *
            ICoinsLeagueSettings(game.settings).getPrizesPlayers()[winners[msg.sender].place]) / 100;
         }else{
            amountSend = amount;
         }

        (bool sent, ) = msg.sender.call{value: amountSend}("");
        require(sent, "Failed to send Ether");
        emit Claimed(msg.sender, winners[msg.sender].place);
    }

    /**
     * house receives 10% of all amount
     */
    function houseClaim() external {
        require(game.finished == true, "Game not finished");
        require(houseClaimed == false, "House Already Claimed");
        houseClaimed = true;
        address house_address = ICoinsLeagueSettings(game.settings).getHouseAddress();

        (bool sent, ) = house_address.call{
            value: amountToHouse()
        }("");
        require(sent, "Failed to send Ether");
        emit HouseClaimed();
    }

    function withdraw() external {
        require(game.aborted == true, "Game not aborted");
        uint256 amount = amounts[msg.sender];
        require(amounts[msg.sender] > 0, "Amount different than zero");
        amounts[msg.sender] = 0;
        (bool sent, bytes memory data) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (
            ,
            int256 price,
            ,
            ,
        ) = AggregatorV3Interface(coin_feed).latestRoundData();
        return price;
    }

    /**
     * View Functions
     */
    function amountToHouse() public view returns (uint256) {
        return (game.total_amount_collected * 10) / 100;
    }

    function totalPlayers() public view returns (uint256) {
        return players.length;
    }

    function playerCoinFeeds(uint256 index)
        external
        view
        returns (address[] memory)
    {
        return players[index].coin_feeds;
    }

    function getPlayers() external view returns (Player[] memory) {
        return players;
    }
}
