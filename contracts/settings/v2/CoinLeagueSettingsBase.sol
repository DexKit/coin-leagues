//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../../interfaces/ICoinLeagueSettingsV2.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// stores all settings of game
contract CoinLeagueSettingsBaseV2 is ICoinLeagueSettingsV2 {
    mapping(address => bool) private _chainlink_feeds;
    mapping(uint256 => bool) private _allowed_amount_players;
    mapping(uint256 => bool) private _allowed_amount_coins;
    mapping(address => bool) private _allowed_coins_to_play;
    mapping(uint256 => bool) private _allowed_amounts;
    mapping(uint256 => bool) private _allowed_amounts_stable;
    mapping(uint256 => bool) private _allowed_time_frames;


    constructor() {
        // AAVE / USD
        _chainlink_feeds[0x3d6774EF702A10b20FCa8Ed40FC022f7E4938e07] = true;
        // ADA / USD
        _chainlink_feeds[0x34cD971a092d5411bD69C10a5F0A7EEF72C69041] = true;
        // AERO / USD
        _chainlink_feeds[0x4EC5970fC728C5f65ba413992CD5fF6FD70fcfF0] = true;
        // AMP / USD
        _chainlink_feeds[0x1688e4B274a4CC9fD398EbA6Ae4dfb6528A9D2bc] = true;
        // APT / USD
        _chainlink_feeds[0x88a98431C25329AA422B21D147c1518b34dD36F4] = true;
        // AVAX / USD
        _chainlink_feeds[0xE70f2D34Fd04046aaEC26a198A35dD8F2dF5cd92] = true;
        // AXL / USD
        _chainlink_feeds[0x676C4C6C31D97A5581D3204C04A8125B350E2F9D] = true;
        // BNB / USD
        _chainlink_feeds[0x4b7836916781CAAfbb7Bd1E5FDd20ED544B453b1] = true;
         // BTC / USD
        _chainlink_feeds[0x64c911996D3c6aC71f9b455B1E8E7266BcbD848F] = true;
         // Comp / USD
        _chainlink_feeds[0x9DDa783DE64A9d1A60c49ca761EbE528C35BA428] = true;
        // Degen / USD
        _chainlink_feeds[0xE62BcE5D7CB9d16AB8b4D622538bc0A50A5799c2] = true;
        // Doge / USD
        _chainlink_feeds[0x8422f3d3CAFf15Ca682939310d6A5e619AE08e57] = true;
        // ETH / USD
        _chainlink_feeds[0x71041dddad3595F9CEd3DcCFBe3D1F4b0a16Bb70] = true;
        // LINK / USD
        _chainlink_feeds[0x17CAb8FE31E32f08326e5E27412894e49B0f9D65] = true;
         // LTC / USD
        _chainlink_feeds[0x206a34e47093125fbf4C75b7c7E88b84c6A77a69] = true;
        // MAVIA / USD
        _chainlink_feeds[0x979447581b39caCA33EF0CA8208592393D16cc13] = true;
          // MELANIA / USD
        _chainlink_feeds[0xFAf372CaBc765b63f6fabD436c845D965eDA1CA5] = true;
        // MEW / USD
        _chainlink_feeds[0x9FB8b5A4b3FE655564f0c76616ae79DE90Cc7382] = true;
        // MLN / USD
        _chainlink_feeds[0x122b5334A8b55861dBc6729c294451471FbF318D] = true;
        // MOG / USD
        _chainlink_feeds[0x4aeb6D15769EaD32D0c5Be2940F40c7CFf53801d] = true;
        // MORPHO / USD
        _chainlink_feeds[0xe95e258bb6615d47515Fc849f8542dA651f12bF6] = true;
       // OGN / USD
        _chainlink_feeds[0x91D7AEd72bF772A0DA30199B925aCB866ACD3D9e] = true;
         // OP / USD
        _chainlink_feeds[0x3E3A6bD129A63564FE7abde85FA67c3950569060] = true;
        // PEPE / USD
        _chainlink_feeds[0xB48ac6409C0c3718b956089b0fFE295A10ACDdad] = true;
        // POL / USD
        _chainlink_feeds[0x5E988c11a4f92155C30D9fb69Ed75597f712B113] = true;
        // RDNT / USD
        _chainlink_feeds[0xEf2E24ba6def99B5e0b71F6CDeaF294b02163094] = true;
        // RSR / USD
        _chainlink_feeds[0xAa98aE504658766Dfe11F31c5D95a0bdcABDe0b1] = true;
        // SHIB / USD
        _chainlink_feeds[0xC8D5D660bb585b68fa0263EeD7B4224a5FC99669] = true;
         // SNX / USD
        _chainlink_feeds[0xe3971Ed6F1A5903321479Ef3148B5950c0612075] = true;
        // SOL / USD
        _chainlink_feeds[0x975043adBb80fc32276CbF9Bbcfd4A601a12462D] = true;
        // STG / USD
        _chainlink_feeds[0x63Af8341b62E683B87bB540896bF283D96B4D385] = true;
        // SUI / USD
        _chainlink_feeds[0x491a921c41d6a97C57426E0c0108a231cd6E5f60] = true;
        // TRUMP / USD
        _chainlink_feeds[0x7bAfa1Af54f17cC0775a1Cf813B9fF5dED2C51E5] = true;
        // Virtual / USD
        _chainlink_feeds[0xEaf310161c9eF7c813A14f8FEF6Fb271434019F7] = true;
        // VVV / USD
        _chainlink_feeds[0x8eC6a128a430f7A850165bcF18facc9520a9873F] = true;
        // WELL/ USD
        _chainlink_feeds[0xc15d9944dAefE2dB03e53bef8DDA25a56832C5fe] = true;
         // WIF/ USD
        _chainlink_feeds[0x674940e1dBf7FD841b33156DA9A88afbD95AaFBa] = true;
           // WMTx/ USD
        _chainlink_feeds[0x311681f6E0b34670Fb03e066cc08C6D09149a44c] = true;
            // XRP/ USD
        _chainlink_feeds[0x9f0C1dD78C4CBdF5b9cf923a549A201EdC676D34] = true;
            // YFI/ USD
        _chainlink_feeds[0xD40e758b5eC80820B68DFC302fc5Ce1239083548] = true;
            // ZRO/ USD
        _chainlink_feeds[0xdc31a4CCfCA039BeC6222e20BE7770E12581bfEB] = true;
 

        // Allowed Amounts
        _allowed_amounts[0.001 ether] = true;
        _allowed_amounts[0.01 ether] = true;
        _allowed_amounts[0.1 ether] = true;
        _allowed_amounts[1 ether] = true;
        _allowed_amounts[3 ether] = true;
        _allowed_amounts[5 ether] = true;
        _allowed_amounts[10 ether] = true;
        _allowed_amounts[25 ether] = true;
        _allowed_amounts[50 ether] = true;
        _allowed_amounts[100 ether] = true;
        _allowed_amounts[250 ether] = true;
        _allowed_amounts[500 ether] = true;

        // Allowed Coins to Play
        _allowed_coins_to_play[
            0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
        ] = true;
        _allowed_coins_to_play[
            0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        ] = true;

        // Allowed Amounts Stable: USDC has 6 decimals on Base
        _allowed_amounts_stable[0.001 * 10**6] = true;
        _allowed_amounts_stable[1 * 10**6] = true;
        _allowed_amounts_stable[5 * 10**6] = true;
        _allowed_amounts_stable[10 * 10**6] = true;
        _allowed_amounts_stable[25 * 10**6] = true;
        _allowed_amounts_stable[50 * 10**6] = true;
        _allowed_amounts_stable[100 * 10**6] = true;
        _allowed_amounts_stable[250 * 10**6] = true;
        _allowed_amounts_stable[500 * 10**6] = true;
        _allowed_amounts_stable[1000 * 10**6] = true;
        _allowed_amounts_stable[2500 * 10**6] = true;
        _allowed_amounts_stable[5000 * 10**6] = true;

        // Allowed Players Amount
        _allowed_amount_players[2] = true;
        _allowed_amount_players[3] = true;
        _allowed_amount_players[5] = true;
        _allowed_amount_players[10] = true;
        _allowed_amount_players[25] = true;
        _allowed_amount_players[50] = true;
        // Allowed Amount Coins
        _allowed_amount_coins[1] = true;
        _allowed_amount_coins[2] = true;
        _allowed_amount_coins[3] = true;
        _allowed_amount_coins[5] = true;
        // Allowed Time Frames
        _allowed_time_frames[60 * 5] = true;
        _allowed_time_frames[60 * 60] = true;
        _allowed_time_frames[60 * 60 * 4] = true;
        _allowed_time_frames[60 * 60 * 8] = true;
        _allowed_time_frames[60 * 60 * 24] = true;
        _allowed_time_frames[60 * 60 * 24 * 7] = true;
        _allowed_time_frames[60 * 60 * 24 * 7 * 30] = true;
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

    function isAllowedAmountsNativeCurrency(uint256 amount)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amounts[amount];
    }

    function isAllowedAmountsStableCurrency(uint256 amount)
        external
        view
        override
        returns (bool)
    {
        return _allowed_amounts_stable[amount];
    }

    function isAllowedCurrency(address coin)
        external
        view
        override
        returns (bool)
    {
        return _allowed_coins_to_play[coin];
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
        return 0x3330b5cbdADB53e91968c6bc12E6A8c5D0C944dd;
    }

    function getEmergencyAddress() external pure override returns (address) {
        return 0xD00995A10dB2E58A1A90270485056629134B151B;
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
        return int256(1200); 
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
            int256(1550),
            int256(1500),
            int256(1450),
            int256(1400),
            int256(1350)
        ];
    }
}
