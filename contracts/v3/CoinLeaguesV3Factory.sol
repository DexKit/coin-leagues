//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/SignedSafeMath.sol";
import "../interfaces/ICoinLeagueSettings.sol";
import "../interfaces/IChampions.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CoinLeagueV3Factory is Ownable {
    using SafeMath for uint256;
    using SignedSafeMath for int256;
    using SafeERC20 for IERC20;
    enum GameType {
        Winner,
        Loser
    }
    event GameCreated(uint256 id);
    event JoinedGame(address playerAddress, address affiliate, uint256 id);
    event StartedGame(uint256 timestamp, uint256 id);
    event EndedGame(uint256 timestamp, uint256 id);
    event AbortedGame(uint256 timestamp, uint256 id);
    event HouseClaimed(uint256 id);
    event Winned(address first, uint256 id);
    event WinnedMultiple(
        address first,
        address second,
        address third,
        uint256 id
    );
    event Claimed(
        address playerAddress,
        uint256 place,
        uint256 amountSend,
        uint256 id
    );
    event Withdrawed(address playerAddress, uint256 timestamp, uint256 id);

    event SettingsChanged(address settingsAddress);
    address internal immutable NativeCoin =
        0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    IChampions internal immutable CHAMPIONS =
        IChampions(0xf2a669A2749073E55c56E27C2f4EdAdb7BD8d95D);

    address public settings;

    struct Player {
        // Struct
        address[] coin_feeds;
        address player_address;
        address captain_coin;
        uint256 champion_id;
        int256 score;
        address affiliate;
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

    mapping(uint256 => mapping(address => Coin)) public coins;

    mapping(uint256 => mapping(address => uint256)) public player_index;

    mapping(uint256 => mapping(address => Winner)) public winners;

    mapping(uint256 => mapping(address => uint256)) public amounts;

    mapping(uint256 => bool) public houseClaims;

    mapping(uint256 => Player[]) public players;

    // Game could be of type loser or winner
    struct Game {
        uint256 id;
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
        address coin_to_play;
    }

    Game[] public games;

    constructor(address _settings, address owner) {
        settings = _settings;
        transferOwnership(owner);
    }

    function createGame(
        uint256 _num_players,
        uint256 _duration,
        uint256 _amount,
        uint256 _num_coins,
        uint256 _abort_timestamp,
        uint256 _start_timestamp,
        GameType _game_type,
        address _coin_to_play
    ) external {
        require(
            ICoinLeagueSettings(settings).isAllowedAmountPlayers(_num_players),
            "Amount of players not supported"
        );
        require(
            ICoinLeagueSettings(settings).isAllowedAmountCoins(_num_coins),
            "Amount of coins not supported"
        );
        require(_abort_timestamp > block.timestamp, "Future date is required");
        require(
            _start_timestamp > block.timestamp - 10 minutes,
            "At least only past 10 minutes dates"
        );
        require(
            ICoinLeagueSettings(settings).isAllowedAmounts(_amount),
            "Amount not supported"
        );
        require(
            ICoinLeagueSettings(settings).isAllowedTimeFrame(_duration),
            "Time Frame not supported"
        );
        require(
            _game_type == GameType.Winner || _game_type == GameType.Loser,
            "Game type not supported"
        );

        games.push(
            Game(
                games.length,
                _game_type,
                false,
                false,
                false,
                false,
                _num_coins,
                _num_players,
                _duration,
                _start_timestamp,
                _abort_timestamp,
                _amount,
                0,
                _coin_to_play
            )
        );
        emit GameCreated(games.length - 1);
    }

    /**
     * Player join game, sending native coin and choosing the price feed
     * TODO: On production use the require for the validation if price feed exists
     */
    function joinGameWithCaptainCoin(
        address[] memory coin_feeds,
        address captain_coin,
        address affiliate,
        uint256 champion_id,
        uint256 id
    ) external payable {
        require(
            players[id].length < games[id].num_players,
            "Game already full"
        );
        require(
            games[id].num_coins == coin_feeds.length + 1,
            "Exceed supported coins"
        );

        require(games[id].started == false, "Game already started");
        require(games[id].aborted == false, "Game was aborted");
        // We pass this number if we want to not use champion id
        if (champion_id != 500000) {
            require(
                CHAMPIONS.ownerOf(champion_id) == msg.sender,
                "You need to own these champions"
            );
        }
        require(
            ICoinLeagueSettings(settings).isChainLinkFeed(captain_coin),
            "Feed not supported"
        );
        for (uint256 index = 0; index < coin_feeds.length; index++) {
            require(
                ICoinLeagueSettings(settings).isChainLinkFeed(
                    coin_feeds[index]
                ),
                "Feed not supported"
            );
            // We create a reference to all coins to easily retrieve a feed later
            coins[id][coin_feeds[index]] = Coin(coin_feeds[index], 0, 0, 0);
        }

        coins[id][captain_coin] = Coin(captain_coin, 0, 0, 0);
        if (amounts[id][msg.sender] == 0) {
            // Native coin address
            if (games[id].coin_to_play == NativeCoin) {
                require(
                    msg.value == games[id].amount_to_play,
                    "You need to sent exactly the value of the pot"
                );
            } else {
                IERC20(games[id].coin_to_play).safeTransferFrom(
                    msg.sender,
                    address(this),
                    games[id].amount_to_play
                );
            }

            amounts[id][msg.sender] = games[id].amount_to_play;
            games[id].total_amount_collected = games[id]
                .total_amount_collected
                .add(msg.value);
            player_index[id][msg.sender] = players[id].length;
            players[id].push(
                Player(
                    coin_feeds,
                    msg.sender,
                    captain_coin,
                    champion_id,
                    0,
                    affiliate
                )
            );
            emit JoinedGame(msg.sender, affiliate, id);
        } else {
            // If player already joined, he can change again all the coins again
            uint256 index = player_index[id][msg.sender];
            players[id][index].captain_coin = captain_coin;
            players[id][index].coin_feeds = coin_feeds;
            players[id][index].champion_id = champion_id;
        }
    }

    /**
     * Called when game is aborted because not started due to not enough players and time elapsed
     *
     */
    function abortGame(uint256 id) external {
        require(
            games[id].started == false,
            "Game started, could not be aborted anymore"
        );
        require(
            players[id].length != games[id].num_players,
            "There is enough players for the game, could not be aborted"
        );
        require(
            block.timestamp > games[id].abort_timestamp,
            "Abort timestamp not elapsed yet"
        );
        games[id].aborted = true;
        emit AbortedGame(block.timestamp, id);
    }

    /**
     * When game starts we get all current prices for the coins of each player
     */
    function startGame(uint256 id) external {
        require(
            block.timestamp >= games[id].start_timestamp,
            "Game can not start yet"
        );
        // If time passed we can start game only with 2 players
        require(players[id].length > 1, "Not meet min number of players");
        require(games[id].aborted == false, "Game was aborted");
        require(games[id].started == false, "Game already started");
        games[id].started = true;
        for (uint256 index = 0; index < players[id].length; index++) {
            Player memory pl = players[id][index];
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_address = pl.coin_feeds[ind];
                Coin storage coin = coins[id][coin_address];
                coin.start_price = getPriceFeed(coin_address);
            }
            Coin storage captainCoin = coins[id][pl.captain_coin];
            captainCoin.start_price = getPriceFeed(pl.captain_coin);
        }
        // We update here again with exact timestamp that game started
        games[id].start_timestamp = block.timestamp;
        emit StartedGame(block.timestamp, id);
    }

    /**
     * Game has ended fetch final price
     */
    function endGame(uint256 id) external {
        require(
            block.timestamp >= games[id].start_timestamp + games[id].duration,
            "Game not ended"
        );
        require(games[id].started == true, "Game needs to start first");
        require(games[id].finished == false, "Game needs already finished");
        games[id].finished = true;
        for (uint256 index = 0; index < players[id].length; index++) {
            Player storage pl = players[id][index];
            pl.score = 0;
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_address = pl.coin_feeds[ind];
                Coin storage coin = coins[id][coin_address];
                coin.end_price = getPriceFeed(coin_address);
                coin.score =
                    ((coin.end_price - coin.start_price) * 100000) /
                    coin.end_price;
            }
            Coin storage captainCoin = coins[id][pl.captain_coin];
            captainCoin.end_price = getPriceFeed(pl.captain_coin);
            captainCoin.score =
                ((captainCoin.end_price - captainCoin.start_price) * 100000) /
                captainCoin.end_price;
            // We compute here the captain coin with the multipliers
            // we only apply captain coin multipliers when it is an advantage for user
            if (
                (games[id].game_type == GameType.Winner &&
                    captainCoin.score > 0) ||
                (games[id].game_type == GameType.Loser && captainCoin.score < 0)
            ) {
                if (
                    pl.champion_id != 500000 &&
                    CHAMPIONS.ownerOf(pl.champion_id) == pl.player_address
                ) {
                    pl.score =
                        pl.score +
                        captainCoin.score *
                        (ICoinLeagueSettings(settings).getHoldingMultiplier() /
                            int256(1000)) *
                        // rarity goes from 0 to 7
                        (ICoinLeagueSettings(settings).getChampionsMultiplier()[
                            CHAMPIONS.getRarityOf(pl.champion_id)
                        ] / int256(1000));
                } else {
                    pl.score =
                        pl.score +
                        (captainCoin.score *
                            ICoinLeagueSettings(settings)
                                .getHoldingMultiplier()) /
                        int256(1000);
                }
            } else {
                pl.score = pl.score + captainCoin.score;
            }
            // Computes scores of game
            for (uint256 ind = 0; ind < pl.coin_feeds.length; ind++) {
                address coin_adress = pl.coin_feeds[ind];
                Coin memory coin = coins[id][coin_adress];
                pl.score = pl.score + coin.score;
            }
        }

        _computeWinners(id);
        emit EndedGame(block.timestamp, id);
    }

    /**
     * compute winners
     */
    function _computeWinners(uint256 id) private {
        int256 score1;
        int256 score2;
        int256 score3;
        if (games[id].game_type == GameType.Winner) {
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
        for (uint256 index = 0; index < players[id].length; index++) {
            int256 score = players[id][index].score;
            if (games[id].game_type == GameType.Winner) {
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
        if (players[id].length > 3) {
            winners[id][players[id][score1_index].player_address] = Winner({
                place: 0,
                winner_address: players[id][score1_index].player_address,
                score: players[id][score1_index].score,
                claimed: false
            });
            winners[id][players[id][score2_index].player_address] = Winner({
                place: 1,
                winner_address: players[id][score2_index].player_address,
                score: players[id][score2_index].score,
                claimed: false
            });
            winners[id][players[id][score3_index].player_address] = Winner({
                place: 2,
                winner_address: players[id][score3_index].player_address,
                score: players[id][score3_index].score,
                claimed: false
            });
            emit WinnedMultiple(
                players[id][score1_index].player_address,
                players[id][score2_index].player_address,
                players[id][score3_index].player_address,
                id
            );
        } else {
            winners[id][players[id][score1_index].player_address] = Winner({
                place: 0,
                winner_address: players[id][score1_index].player_address,
                score: score1,
                claimed: false
            });
            emit Winned(players[id][score1_index].player_address, id);
        }
    }

    function claim(address payable owner, uint256 id) external {
        require(games[id].finished == true, "Game not finished");
        require(
            winners[id][owner].winner_address == owner,
            "You are not a winner"
        );
        require(winners[id][owner].claimed == false, "You already claimed");
        winners[id][owner].claimed = true;
        uint256 amount = games[id].total_amount_collected - amountToHouse(id);
        uint256 amountSend;
        if (players[id].length > 3) {
            amountSend =
                (amount *
                    ICoinLeagueSettings(settings).getPrizesPlayers()[
                        winners[id][owner].place
                    ]) /
                100;
        } else {
            amountSend = amount;
        }
        if (games[id].coin_to_play == NativeCoin) {
            (bool sent, ) = owner.call{value: amountSend}("");
            require(sent, "Failed to send Ether");
        } else {
            IERC20(games[id].coin_to_play).safeTransfer(owner, amountSend);
        }

        emit Claimed(owner, winners[id][owner].place, amountSend, id);
    }

    /**
     * house receives 10% of all amount
     */
    function houseClaim(uint256 id) external {
        require(games[id].finished == true, "Game not finished");
        require(houseClaims[id] == false, "House Already Claimed");
        houseClaims[id] = true;
        address house_address = ICoinLeagueSettings(settings).getHouseAddress();
        if (games[id].coin_to_play == NativeCoin) {
            (bool sent, ) = house_address.call{value: amountToHouse(id)}("");
            require(sent, "Failed to send Ether");
        } else {
            IERC20(games[id].coin_to_play).safeTransfer(
                house_address,
                amountToHouse(id)
            );
        }
        emit HouseClaimed(id);
    }

    function withdraw(address payable withdrawer, uint256 id) external {
        require(games[id].aborted == true, "Game not aborted");
        uint256 amount = amounts[id][withdrawer];
        require(amounts[id][withdrawer] > 0, "Amount different than zero");
        amounts[id][withdrawer] = 0;
        if (games[id].coin_to_play == NativeCoin) {
            (bool sent, ) = withdrawer.call{value: amount}("");
            require(sent, "Failed to send Ether");
        } else {
            IERC20(games[id].coin_to_play).safeTransfer(withdrawer, amount);
        }
        emit Withdrawed(withdrawer, block.timestamp, id);
    }

    // We call emergency when something buggy happens with one game, only to be used in last case, this likely mess's factory contract so need to be carefully
    // decided before called
    function emergency(uint256 id) external {
        require(
            ICoinLeagueSettings(settings).getEmergencyAddress() == msg.sender,
            "Only emergency address can call emergency"
        );
        games[id].aborted = true;
        emit AbortedGame(block.timestamp, id);
    }

    function setSettings(address newSettings) public onlyOwner {
        require(newSettings != address(0), "Settings can not be zero address");
        settings = newSettings;
        emit SettingsChanged(newSettings);
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(coin_feed)
            .latestRoundData();
        return price;
    }

    /**
     * View Functions
     */
    function amountToHouse(uint256 id) public view returns (uint256) {
        return (games[id].total_amount_collected * 10) / 100;
    }

    function totalPlayers(uint256 id) public view returns (uint256) {
        return players[id].length;
    }

    function playerCoinFeeds(uint256 index, uint256 id)
        external
        view
        returns (address[] memory)
    {
        return players[id][index].coin_feeds;
    }

    function getPlayers(uint256 id) external view returns (Player[] memory) {
        return players[id];
    }
}
