//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/ICoinsLeagueSettings.sol";

// stores all settings of game
contract CoinsLeagueSettingsMumbai is ICoinsLeagueSettings {
     mapping(address => bool) private _chainlink_feeds;
     mapping(uint256 => bool) private _allowed_amount_players;
     mapping(uint256 => bool) private _allowed_amount_coins;
     mapping(uint256 => bool) private _allowed_amounts;
     mapping(uint256 => bool) private _allowed_time_frames;

     constructor(){
          // BTC / USD
        _chainlink_feeds[0x007A22900a3B98143368Bd5906f8E17e9867581b] = true;
        // DAI / USD
        _chainlink_feeds[0x0FCAa9c899EC5A91eBc3D5Dd869De833b06fB046] = true;
        // ETH / USD
        _chainlink_feeds[0x0715A7794a1dc8e42615F059dD6e406A6594651A] = true;
        // MATIC / USD
        _chainlink_feeds[0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada] = true;
        // USDC / USD
        _chainlink_feeds[0x572dDec9087154dC5dfBB1546Bb62713147e0Ab0] = true;
        // USDT / USD
        _chainlink_feeds[0x92C09849638959196E976289418e5973CC96d645] = true;

         // Allowed Amounts
        _allowed_amounts[0.01 ether] = true;
        _allowed_amounts[0.1 ether] = true;
        _allowed_amounts[1 ether]   = true;
        _allowed_amounts[3 ether]   = true;
        _allowed_amounts[5 ether]   = true;
        _allowed_amounts[25 ether]  = true;
        _allowed_amounts[50 ether]  = true;
        _allowed_amounts[250 ether] = true;
         // Allowed Players Amount
        _allowed_amount_players[2]  = true;
        _allowed_amount_players[5]  = true;
        _allowed_amount_players[10] = true;
        // Allowed Amount Coins
        _allowed_amount_coins[1]  = true;
        _allowed_amount_coins[2]  = true;
        _allowed_amount_coins[5]  = true;
        _allowed_amount_coins[10] = true;
         // Allowed Time Frames
        _allowed_time_frames[60*60]  = true;
        _allowed_time_frames[60*60*4]  = true;
        _allowed_time_frames[60*60*8]  = true;
        _allowed_time_frames[60*60*24]  = true;
        _allowed_time_frames[60*60*24*7]  = true;
     }

    function isChainLinkFeed(address feed) external view override returns (bool) {
        require(feed != address(0), "No zero address feed");
        return _chainlink_feeds[feed];
    }

    function isAllowedAmountPlayers(uint256 num) external view override  returns (bool){
         return _allowed_amount_players[num];
     }

     function isAllowedAmounts(uint256 amount) external view override  returns (bool){
         return _allowed_amounts[amount];
     }

     function isAllowedAmountCoins(uint256 num) external view override  returns (bool){
         return _allowed_amount_coins[num];
     }

    function isAllowedTimeFrame(uint256 time) external view override  returns (bool){
         return _allowed_time_frames[time];
     }

    function getHouseAddress() external pure override  returns (address){
         return 0x5bD68B4d6f90Bcc9F3a9456791c0Db5A43df676d;
    }

     function getPrizesPlayers() external pure override  returns (uint256[3] memory){
        return [uint256(60), uint256(30), uint256(10)];
     }
     function getBITTMultiplier() external view override  returns (uint256){
         return 1;
     }
     function getChampionsMultiplier() external override  view returns (uint256){
         return 1;
     }




}