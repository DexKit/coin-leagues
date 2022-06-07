//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/ICoinLeagueSettings.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// stores all settings of game
contract CoinLeagueSettingsETH is ICoinLeagueSettings {
    mapping(address => bool) private _chainlink_feeds;
    mapping(uint256 => bool) private _allowed_amount_players;
    mapping(uint256 => bool) private _allowed_amount_coins;
    mapping(uint256 => bool) private _allowed_amounts;
    mapping(uint256 => bool) private _allowed_time_frames;
     IERC20 internal immutable BITTOKEN =
        IERC20(0x9F9913853f749b3fE6D6D4e16a1Cc3C1656B6D51);
    IERC20 internal immutable DEXKIT =
        IERC20(0x7866E48C74CbFB8183cd1a929cd9b95a7a5CB4F4);
    uint256 constant HOLDING_BITT_MULTIPLIER = 200 * 10**18;
    uint256 constant HOLDING_KIT_MULTIPLIER = 50 * 10**18;

    constructor() {
        //1inch / USD
        _chainlink_feeds[0xc929ad75B72593967DE83E7F7Cda0493458261D9] = true;
        // aave / USD
        _chainlink_feeds[0x547a514d5e3769680Ce22B2361c10Ea13619e8a9] = true;
        // ada / USD
        _chainlink_feeds[0xAE48c91dF1fE419994FFDa27da09D5aC69c30f55] = true;
        // BNB / USD
        _chainlink_feeds[0x14e613AC84a31f709eadbdF89C6CC390fDc9540A] = true;
        // BNT / USD
        _chainlink_feeds[0x1E6cF0D433de4FE882A437ABC654F58E1e78548c] = true;
        // BTC / USD
        _chainlink_feeds[0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c] = true;
        // CRO/USD
        _chainlink_feeds[0x00Cb80Cf097D9aA9A3779ad8EE7cF98437eaE050] = true;
        // AVAX/USD
        _chainlink_feeds[0xFF3EEb22B5E3dE6e705b44749C2559d704923FD7] = true;
        // AVAX/USD
        _chainlink_feeds[0xFF3EEb22B5E3dE6e705b44749C2559d704923FD7] = true;
        // Band/USD
        _chainlink_feeds[0x919C77ACc7373D000b329c1276C76586ed2Dd19F] = true;

        // Allowed Amounts
        _allowed_amounts[0.01 ether] = true;
        _allowed_amounts[0.1 ether] = true;
        _allowed_amounts[1 ether] = true;
        _allowed_amounts[3 ether] = true;
        _allowed_amounts[5 ether] = true;
        _allowed_amounts[25 ether] = true;
        _allowed_amounts[50 ether] = true;
        _allowed_amounts[250 ether] = true;
        // Allowed Players Amount
        _allowed_amount_players[2] = true;
        _allowed_amount_players[5] = true;
        _allowed_amount_players[10] = true;
        _allowed_amount_players[20] = true;
        _allowed_amount_players[25] = true;
        _allowed_amount_players[100] = true;
        // Allowed Amount Coins
        _allowed_amount_coins[1] = true;
        _allowed_amount_coins[2] = true;
        _allowed_amount_coins[3] = true;
        _allowed_amount_coins[5] = true;
        _allowed_amount_coins[9] = true;
        _allowed_amount_coins[10] = true;
        // Allowed Time Frames
        _allowed_time_frames[60 * 60] = true;
        _allowed_time_frames[5 * 60] = true;
        _allowed_time_frames[60 * 60 * 4] = true;
        _allowed_time_frames[60 * 60 * 8] = true;
        _allowed_time_frames[60 * 60 * 24] = true;
        _allowed_time_frames[60 * 60 * 24 * 7] = true;
    }

    function isChainLinkFeed(address feed)
        external
        view
        override
        returns (bool)
    {
        require(feed != address(0), "No zero address feed");
        return _chainlink_feeds[feed];
    }

    function isAllowedAmountPlayers(uint256 num)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amount_players[num];
    }

    function isAllowedAmounts(uint256 amount)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amounts[amount];
    }

    function isAllowedAmountCoins(uint256 num)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amount_coins[num];
    }

    function isAllowedTimeFrame(uint256 time)
        external
        view
        override
        returns (bool)
    {
        return _allowed_time_frames[time];
    }

    function getHouseAddress() external pure override returns (address) {
        return 0x5bD68B4d6f90Bcc9F3a9456791c0Db5A43df676d;
    }

    function getEmergencyAddress() external pure override returns (address) {
        return 0x5bD68B4d6f90Bcc9F3a9456791c0Db5A43df676d;
    }

    function getPrizesPlayers()
        external
        pure
        override
        returns (uint256[3] memory)
    {
        return [uint256(60), uint256(30), uint256(10)];
    }

    function getHoldingMultiplier() external view override returns (int256) {
        if (
            BITTOKEN.balanceOf(msg.sender) >= HOLDING_BITT_MULTIPLIER ||
            DEXKIT.balanceOf(msg.sender) >= HOLDING_KIT_MULTIPLIER
        ) {
            return int256(1300);
        } else {
            return int256(1200);
        }
    }

    function getChampionsMultiplier()
        external
        pure
        override
        returns (int256[8] memory)
    {
        return [
            int256(1700),
            int256(1650),
            int256(1600),
            int256(1600),
            int256(1550),
            int256(1500),
            int256(1400),
            int256(1350)
        ];
    }
}
