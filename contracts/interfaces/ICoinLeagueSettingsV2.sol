//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface ICoinLeagueSettingsV2 {
    function isChainLinkFeed(address feed) external view returns (bool);

    function isAllowedAmountPlayers(uint256) external view returns (bool);

    function isAllowedAmountsNativeCurrency(uint256)
        external
        view
        returns (bool);

    function isAllowedAmountsStableCurrency(uint256)
        external
        view
        returns (bool);

    function isAllowedCurrency(address coin) external view returns (bool);

    function isAllowedAmountCoins(uint256) external view returns (bool);

    function isAllowedTimeFrame(uint256) external view returns (bool);

    function getPrizesPlayers() external view returns (uint256[3] memory);

    function getHouseAddress() external pure returns (address);

    function getEmergencyAddress() external pure returns (address);

    function getHoldingMultiplier() external view returns (int256);

    function getChampionsMultiplier() external view returns (int256[8] memory);
}
