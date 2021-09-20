//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface ICoinsLeagueSettings2 {
    function getGameRules(address feed) external view returns (bool);
    function isAllowedAmountPlayers(uint256) external view returns (bool);
    function isAllowedAmounts(uint256) external view returns (bool);
    function isAllowedAmountCoins(uint256) external view returns (bool);
    function isAllowedTimeFrame(uint256) external view returns (bool);
    function getPrizesTwoPlayers() external view returns (uint256[2] memory);
    function getPrizesPlayers() external view returns (uint256[3] memory);
    function getHouseAddress() external returns (address);
    function getBITTMultiplier() external returns (uint256);
    function getChampionsMultiplier() external returns (uint256);
}
