//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/SignedSafeMath.sol";
import "../../interfaces/ICoinLeagueSettings.sol";
import "../../interfaces/IChampions.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CoinLeagues is Ownable {
    using SafeMath for uint256;
    using SignedSafeMath for int256;
    enum GameType {
        Winner,
        Loser
    }
    uint256 public id;

    event JoinedGame(address playerAddress);
    event StartedGame(uint256 timestamp);
    event EndedGame(uint256 timestamp);
    event AbortedGame(uint256 timestamp);
    event HouseClaimed();
    event Winned(address first);
    event WinnedMultiple(address first, address second, address third);
    event Claimed(address playerAddress, uint256 place, uint256 amountSend);

    IChampions internal immutable CHAMPIONS =
        IChampions(0xf2a669A2749073E55c56E27C2f4EdAdb7BD8d95D);
    struct Player {
        // Struct
        address[] coin_feeds;
        address player_address;
        address captain_coin;
        uint256 champion_id;
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
        address _settingsAddress,
        uint256 _id
    ) {
        game.settings = _settingsAddress;
        require(
            ICoinLeagueSettings(game.settings).isAllowedAmountPlayers(
                _num_players
            ),
            "Amount of players not supported"
        );
        require(
            ICoinLeagueSettings(game.settings).isAllowedAmountCoins(_num_coins),
            "Amount of coins not supported"
        );
        require(_abort_timestamp > block.timestamp, "Future date is required");
        require(
            ICoinLeagueSettings(game.settings).isAllowedAmounts(_amount),
            "Amount not supported"
        );
        require(
            ICoinLeagueSettings(game.settings).isAllowedTimeFrame(_duration),
            "Time Frame not supported"
        );
        require(
            _game_type == GameType.Winner || _game_type == GameType.Loser,
            "Game type not supported"
        );

        game.num_players = _num_players;
        game.duration = _duration;
        game.game_type = _game_type;
        game.amount_to_play = _amount;
        game.num_coins = _num_coins;
        game.abort_timestamp = _abort_timestamp;
        id = _id;
    }

    /**
     * Player join game, sending native coin and choosing the price feed
     * TODO: On production use the require for the validation if price feed exists
     */
    function joinGameWithCaptainCoin(
        address[] memory coin_feeds,
        address captain_coin,
        uint256 champion_id
    ) external payable {
        require(players.length < game.num_players, "Game already full");
        require(
            game.num_coins == coin_feeds.length + 1,
            "Exceed supported coins"
        );
        require(
            msg.value == game.amount_to_play,
            "You need to sent exactly the value of the pot"
        );
        require(game.aborted == false, "Game was aborted");
        require(amounts[msg.sender] == 0, "You Already joined");
        // We pass this number if we want to not use champion id
        if (champion_id != 500000) {
            require(
                CHAMPIONS.ownerOf(champion_id) == msg.sender,
                "You need to own these champions"
            );
        }
        require(
            ICoinLeagueSettings(game.settings).isChainLinkFeed(captain_coin),
            "Feed not supported"
        );
        for (uint256 index = 0; index < coin_feeds.length; index++) {
            require(
                ICoinLeagueSettings(game.settings).isChainLinkFeed(
                    coin_feeds[index]
                ),
                "Feed not supported"
            );
            // We create a reference to all coins to easily retrieve a feed later
            coins[coin_feeds[index]] = Coin(coin_feeds[index], 0, 0, 0);
        }

        coins[captain_coin] = Coin(captain_coin, 0, 0, 0);
        amounts[msg.sender] = msg.value;
        game.total_amount_collected = game.total_amount_collected.add(
            msg.value
        );
        players.push(
            Player(coin_feeds, msg.sender, captain_coin, champion_id, 0)
        );
        emit JoinedGame(msg.sender);
    }

    /**
     * Called when game is aborted because not started due to not enough players and time elapsed
     *
     */
    function abortGame() external onlyOwner {
        require(
            game.started == false,
            "Game started, could not be aborted anymore"
        );
        require(
            players.length != game.num_players,
            "There is enough players for the game, could not be aborted"
        );
        require(
            block.timestamp > game.abort_timestamp,
            "Abort timestamp not elapsed yet"
        );
        game.aborted = true;
        emit AbortedGame(block.timestamp);
    }

    /**
     * When game starts we get all current prices for the coins of each player
     */
    function startGame() external onlyOwner {
        require(
            players.length == game.num_players,
            "Not meet min number of players"
        );
        require(game.aborted == false, "Game was aborted");
        require(game.started == false, "Game already started");
        game.started = true;
        game.start_timestamp = block.timestamp;
        for (uint256 index = 0; index < players.length; index++) {
            Player memory pl = players[index];
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_address = pl.coin_feeds[ind];
                Coin storage coin = coins[coin_address];
                coin.start_price = getPriceFeed(coin_address);
            }
            Coin storage captainCoin = coins[pl.captain_coin];
            captainCoin.start_price = getPriceFeed(pl.captain_coin);
        }
        emit StartedGame(block.timestamp);
    }

    /**
     * Game has ended fetch final price
     */
    function endGame() external onlyOwner {
        require(
            block.timestamp >= game.start_timestamp + game.duration,
            "Game not ended"
        );
        require(game.started == true, "Game needs to start first");
        require(game.finished == false, "Game needs already finished");
        game.finished = true;
        for (uint256 index = 0; index < players.length; index++) {
            Player storage pl = players[index];
            pl.score = 0;
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_address = pl.coin_feeds[ind];
                Coin storage coin = coins[coin_address];
                coin.end_price = getPriceFeed(coin_address);
                coin.score =
                    ((coin.end_price - coin.start_price) * 100000) /
                    coin.end_price;
            }
            Coin storage captainCoin = coins[pl.captain_coin];
            captainCoin.end_price = getPriceFeed(pl.captain_coin);
            captainCoin.score =
                ((captainCoin.end_price - captainCoin.start_price) * 100000) /
                captainCoin.end_price;
            // We compute here the captain coin with the multipliers
            // we only apply captain coin multipliers when it is an advantage for user
            if (
                (game.game_type == GameType.Winner && captainCoin.score > 0) ||
                (game.game_type == GameType.Loser && captainCoin.score < 0)
            ) {
                if (
                    pl.champion_id != 500000 &&
                    CHAMPIONS.ownerOf(pl.champion_id) == pl.player_address
                ) {
                    pl.score =
                        pl.score +
                        captainCoin.score *
                        (ICoinLeagueSettings(game.settings)
                            .getHoldingMultiplier() / int256(1000)) *
                        // rarity goes from 0 to 7
                        (ICoinLeagueSettings(game.settings)
                            .getChampionsMultiplier()[
                                CHAMPIONS.getRarityOf(pl.champion_id)
                            ] / int256(1000));
                } else {
                    pl.score =
                        pl.score +
                        (captainCoin.score *
                            ICoinLeagueSettings(game.settings)
                                .getHoldingMultiplier()) /
                        int256(1000);
                }
            } else {
                pl.score = pl.score + captainCoin.score;
            }
            // Computes scores of game
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
            score1 = -1000000000;
            score2 = -1000000000;
            score3 = -1000000000;
        } else {
            score1 = 1000000000;
            score2 = 1000000000;
            score3 = 1000000000;
        }
        uint256 score1_index = 0;
        uint256 score2_index = 1;
        uint256 score3_index = 2;
        for (uint256 index = 0; index < players.length; index++) {
            int256 score = players[index].score;
            if (game.game_type == GameType.Winner) {
                if (score > score1) {
                    // We need to do this to sort properly always the winners
                    if (score1 > score2) {
                        if (score2 > score3) {
                            score3_index = score2_index;
                            score3 = score2;
                        }
                        score2_index = score1_index;
                        score2 = score1;
                    }

                    score1_index = index;
                    score1 = score;
                } else if (score > score2) {
                    if (score2 > score3) {
                        score3_index = score2_index;
                        score3 = score2;
                    }
                    score2_index = index;
                    score2 = score;
                } else if (score > score3) {
                    score3 = score;
                    score3_index = index;
                }
            } else {
                if (score < score1) {
                    if (score1 < score2) {
                        if (score2 < score3) {
                            score3_index = score2_index;
                            score3 = score2;
                        }
                        score2_index = score1_index;
                        score2 = score1;
                    }
                    score1_index = index;
                    score1 = score;
                } else if (score < score2) {
                    if (score2 < score3) {
                        score3_index = score2_index;
                        score3 = score2;
                    }
                    score2_index = index;
                    score2 = score;
                } else if (score < score3) {
                    score3 = score;
                    score3_index = index;
                }
            }
        }
        if (players.length > 3) {
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
            emit WinnedMultiple(
                players[score1_index].player_address,
                players[score2_index].player_address,
                players[score3_index].player_address
            );
        } else {
            winners[players[score1_index].player_address] = Winner({
                place: 0,
                winner_address: players[score1_index].player_address,
                score: score1,
                claimed: false
            });
            emit Winned(players[score1_index].player_address);
        }
    }

    function claim(address payable owner) external {
        require(game.finished == true, "Game not finished");
        require(winners[owner].winner_address == owner, "You are not a winner");
        require(winners[owner].claimed == false, "You already claimed");
        winners[owner].claimed = true;
        uint256 amount = game.total_amount_collected - amountToHouse();
        uint256 amountSend;
        if (players.length > 3) {
            amountSend =
                (amount *
                    ICoinLeagueSettings(game.settings).getPrizesPlayers()[
                        winners[owner].place
                    ]) /
                100;
        } else {
            amountSend = amount;
        }

        (bool sent, ) = owner.call{value: amountSend}("");
        require(sent, "Failed to send Ether");
        emit Claimed(owner, winners[owner].place, amountSend);
    }

    /**
     * house receives 10% of all amount
     */
    function houseClaim() external {
        require(game.finished == true, "Game not finished");
        require(houseClaimed == false, "House Already Claimed");
        houseClaimed = true;
        address house_address = ICoinLeagueSettings(game.settings)
            .getHouseAddress();

        (bool sent, ) = house_address.call{value: amountToHouse()}("");
        require(sent, "Failed to send Ether");
        emit HouseClaimed();
    }

    function withdraw() external {
        require(game.aborted == true, "Game not aborted");
        uint256 amount = amounts[msg.sender];
        require(amounts[msg.sender] > 0, "Amount different than zero");
        amounts[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    // We call emergency when something buggy happens with one game, only to be used in last case, this likely mess's factory contract so need to be carefully
    // decided before called
    function emergency() external {
        require(
            ICoinLeagueSettings(game.settings).getEmergencyAddress() ==
                msg.sender,
            "Only emergency address can call emergency"
        );
        game.aborted = true;
        emit AbortedGame(block.timestamp);
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(coin_feed)
            .latestRoundData();
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
