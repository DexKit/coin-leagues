//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/IChampions.sol";

contract BattleNFTFactoryMumbai is Ownable {
    enum GameType {
        Winner,
        Loser
    }

    IChampions internal immutable CHAMPIONS =
        IChampions(0x05b93425E4b44c9042Ed97b7A332aB1575EbD25d);

    address HOUSE = 0x3330b5cbdADB53e91968c6bc12E6A8c5D0C944dd;

    event CreatedGame(
        uint256 id,
        uint256 champion_id,
        address created_by,
        uint256 created_at
    );
    event JoinedGame(
        uint256 id,
        uint256 champion_id,
        address created_by,
        uint256 created_at
    );
    event GameStarted(uint256 id, uint256 created_at);
    event GameFinished(uint256 id, uint256 created_at, address winner);
    event Claimed(
        uint256 id,
        uint256 amount,
        address claimer,
        uint256 created_at
    );
    event Aborted(uint256 id, uint256 created_at);
    event Withdrawed(uint256 id, uint256 created_at);

    struct Coin {
        // Struct
        address coin_feed;
        uint256 champion_id;
        int256 multiplier;
        int256 start_price;
        int256 end_price;
        int256 score;
        int256 champion_score;
    }

    mapping(uint256 => Coin) public coin_player1;
    mapping(uint256 => Coin) public coin_player2;

    struct Game {
        uint256 id;
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
        GameType game_type;
    }

    Game[] public allGames;

    /**
     * Create battle and join at same time
     *
     */
    function createAndJoinGame(
        uint256 champion_id,
        uint256 bitt_feed,
        int256 multiplier,
        uint256 start_timestamp,
        uint256 duration,
        uint256 entry,
        GameType _game_type
    ) external payable {
        require(entry == msg.value, "Sent exact value");
        require(start_timestamp > block.timestamp, "require future date");
        require(
            CHAMPIONS.ownerOf(champion_id) == msg.sender,
            "You need to own this champion"
        );
        uint256 rarity = CHAMPIONS.getRarityOf(champion_id);

        uint256 id = allGames.length;
        // Bittoken can impersonate other coins
        if (rarity == 0) {
            require(bitt_feed > 0 && bitt_feed < 8, "feed not supported");
            coin_player1[id].coin_feed = getChampionsFeed()[bitt_feed];
        } else {
            coin_player1[id].coin_feed = getChampionsFeed()[rarity];
        }
        coin_player1[id].champion_id = champion_id;
        coin_player1[id].multiplier = multiplier;

        allGames.push(
            Game(
                id,
                false,
                false,
                false,
                false,
                false,
                entry,
                msg.sender,
                address(0),
                duration,
                start_timestamp,
                address(0),
                _game_type
            )
        );
        emit CreatedGame(id, champion_id, msg.sender, block.timestamp);
    }

    function joinGame(
        uint256 id,
        uint256 champion_id,
        uint256 bitt_feed,
        int256 multiplier
    ) external payable {
        require(id < allGames.length, "Game not exists");
        Game storage game = allGames[id];
        require(game.player2 == address(0), "game already full");
        game.player2 = msg.sender;
        require(game.entry == msg.value, "Sent exact value");
        require(game.started == false, "Game already started");
        require(
            CHAMPIONS.ownerOf(champion_id) == msg.sender,
            "You need to own this champion"
        );
        uint256 rarity = CHAMPIONS.getRarityOf(champion_id);
        // Bittoken can impersonate other coins
        if (rarity == 0) {
            require(bitt_feed > 0 && bitt_feed < 9, "feed not supported");
            coin_player2[id].coin_feed = getChampionsFeed()[bitt_feed];
        } else {
            coin_player2[id].coin_feed = getChampionsFeed()[rarity];
        }
        coin_player2[id].multiplier = multiplier;
        coin_player2[id].champion_id = champion_id;
        emit JoinedGame(id, champion_id, msg.sender, block.timestamp);
    }

    function startGame(uint256 id) external {
        require(id < allGames.length);
        Game storage game = allGames[id];
        require(
            block.timestamp > game.start_timestamp,
            "Game can not start yet"
        );
        require(game.started == false, "game already started");
        require(game.aborted == false, "Game  aborted");
        require(game.player2 != address(0), "game not full");
        coin_player1[id].start_price = getPriceFeed(coin_player1[id].coin_feed);
        coin_player2[id].start_price = getPriceFeed(coin_player2[id].coin_feed);
        game.started = true;
        emit GameStarted(id, block.timestamp);
    }

    function endGame(uint256 id) external {
        require(id < allGames.length, "id not supported");
        Game storage game = allGames[id];
        require(game.started == true, "game not started");
        require(game.aborted == false, "Game  aborted");
        require(game.finished == false, "game not finished");
        require(
            block.timestamp > game.start_timestamp + game.duration,
            "duration still not elapsed"
        );
        coin_player1[id].end_price = getPriceFeed(coin_player1[id].coin_feed);
        coin_player2[id].end_price = getPriceFeed(coin_player2[id].coin_feed);
        coin_player1[id].score =
            (((coin_player1[id].end_price - coin_player1[id].start_price)) /
                coin_player1[id].end_price) *
            coin_player1[id].multiplier;
        coin_player2[id].score =
            (((coin_player2[id].end_price - coin_player2[id].start_price)) /
                coin_player2[id].end_price) *
            coin_player2[id].multiplier;
        // If it is type loser we just negate the score;
        if (game.game_type == GameType.Loser) {
            coin_player1[id].score = -coin_player1[id].score;
            coin_player2[id].score = -coin_player2[id].score;
        }
        uint256 champion1 = coin_player1[id].champion_id;
        uint256 champion2 = coin_player2[id].champion_id;
        coin_player1[id].champion_score =
            coin_player1[id].score +
            int256(CHAMPIONS.attack(champion1)) +
            int256(CHAMPIONS.run(champion1)) +
            int256(CHAMPIONS.defense(champion1));
        coin_player2[id].champion_score =
            coin_player2[id].score +
            int256(CHAMPIONS.attack(champion2)) +
            int256(CHAMPIONS.run(champion2)) +
            int256(CHAMPIONS.defense(champion2));
        // In case of draw, the creator wins
        if (
            coin_player1[id].champion_score >= coin_player2[id].champion_score
        ) {
            game.winner = game.player1;
        } else {
            game.winner = game.player2;
        }

        game.finished = true;
        emit GameFinished(id, block.timestamp, game.winner);
        // Claim when game finished
        claim(id);
    }

    function claim(uint256 id) public {
        require(id < allGames.length);
        Game storage game = allGames[id];
        require(game.claimed == false, "Already claimed");
        require(game.finished == true, "Game not finished");
        require(game.winner != address(0), "Winner not zero address");
        game.claimed = true;
        uint256 totalPrize = game.entry * 2;
        // House takes 10% of the game, wich is 2 * game entry
        uint256 amountHouse = (totalPrize * 10) / 100;
        uint256 amountWinner = totalPrize - amountHouse;

        (bool sentHouse, ) = HOUSE.call{value: amountHouse}("");
        require(sentHouse, "Failed to send Ether");
        (bool sent, ) = game.winner.call{value: amountWinner}("");
        require(sent, "Failed to send Ether");
        emit Claimed(id, amountWinner, game.winner, block.timestamp);
    }

    function abortGameAndWithraw(uint256 id) external {
        require(id < allGames.length);
        Game storage game = allGames[id];
        require(game.started == false, "Game  already started");
        require(game.aborted == false, "Game  already aborted");
        require(game.player2 == address(0), "Game  is already full");
        game.aborted = true;
        emit Aborted(id, block.timestamp);
        game.withdrawed = true;
        (bool sent, ) = game.player1.call{value: game.entry}("");
        require(sent, "Failed to send Ether");
        emit Withdrawed(id, block.timestamp);
    }

    function abortGame(uint256 id) external {
        require(id < allGames.length);
        Game storage game = allGames[id];
        require(game.started == false, "Game  already started");
        require(game.aborted == false, "Game  already aborted");
        require(game.player2 == address(0), "Game  is already full");
        game.aborted = true;
        emit Aborted(id, block.timestamp);
    }

    function withdraw(uint256 id) internal {
        Game storage game = allGames[id];
        require(game.aborted == true, "Game  not aborted");
        require(game.withdrawed == false, "Game already withdrawed");
        game.withdrawed = true;
        (bool sent, ) = game.player1.call{value: game.entry}("");
        require(sent, "Failed to send Ether");
        emit Withdrawed(id, block.timestamp);
    }

    /**
     * returns feed associated with coin
     */
    function getChampionsFeed() internal pure returns (address[8] memory) {
        return [
            // Bittoken Jocker, could be anyone
            address(0),
            // BTC
            0x007A22900a3B98143368Bd5906f8E17e9867581b,
            // ETH
            0x0715A7794a1dc8e42615F059dD6e406A6594651A,
            // Matic
            0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada,
            // Matic
            0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada,
            // Matic
            0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada,
            // Matic
            0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada,
            // Matic
            0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada
        ];
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(coin_feed)
            .latestRoundData();
        return price;
    }
}
