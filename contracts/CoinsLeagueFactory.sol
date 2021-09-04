//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinsLeague.sol";

/**
 *
 * Factory that creates the games and stores a reference to each game
 *
 *
 */
contract CoinsLeagueFactory {
    CoinsLeague[] public coinsLeague;

    event GameCreated(address gameAddress, uint256 id);

    /**
     * Create game and store reference on array
     */
    function createGame(
        uint8 _num_players,
        uint256 _duration,
        uint256 _amount,
        uint8 _num_coins,
        uint256 _abort_timestamp
    ) external returns (CoinsLeague gameAddress) {
        gameAddress = new CoinsLeague(
            _num_players,
            _duration,
            _amount,
            _num_coins,
            _abort_timestamp
        );
        coinsLeague.push(gameAddress);
        emit GameCreated(address(gameAddress), coinsLeague.length);
    }

    //@dev used to get multiple games at once
    function getGames(uint256 start, uint256 end)
        external
        returns (address[] memory)
    {
        require(
            end < coinsLeague.length,
            "end indice must be lower than total games"
        );
        require(end > start, "end must be bigger than start");
        uint256 total = end - start;
        address[] memory games = new address[](total);
        uint256 j = 0;
        for (uint256 index = start; index < end; index++) {
            games[j] = address(coinsLeague[index]);
            j++;
        }
        return games;
    }

    function totalGames() external view returns (uint256) {
        return coinsLeague.length;
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = AggregatorV3Interface(coin_feed).latestRoundData();
        return price;
    }


}
