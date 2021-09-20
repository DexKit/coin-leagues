//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./CoinsLeague.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/**
 *
 * Factory that creates the games and stores a reference to each game
 *
 *
 */
contract CoinsLeagueFactory is Ownable {
    CoinsLeague[] public coinsLeague;
    address private _settings;

    event GameCreated(address gameAddress, uint256 id);
    event SettingsChanged(address settingsAddress);

    constructor(address settings) {
        _settings = settings;
    }


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
            _abort_timestamp,
            _settings
        );
        coinsLeague.push(gameAddress);
        emit GameCreated(address(gameAddress), coinsLeague.length);
    }

    //@dev used to get multiple games at once
    function getGames(uint256 start, uint256 end)
        external view
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
           ,
            int256 price,
            ,
            ,
   
        ) = AggregatorV3Interface(coin_feed).latestRoundData();
        return price;
    }

    function setSettings(address newSettings) public onlyOwner(){
        require(newSettings != address(0), "Settings can not be zero address");
        emit SettingsChanged(newSettings);
    }


}
