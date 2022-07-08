//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../../interfaces/ICoinLeagueSettingsV2.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// stores all settings of game
contract CoinLeagueSettingsMaticV2 is ICoinLeagueSettingsV2 {
    mapping(address => bool) private _chainlink_feeds;
    mapping(uint256 => bool) private _allowed_amount_players;
    mapping(uint256 => bool) private _allowed_amount_coins;
    mapping(address => bool) private _allowed_coins_to_play;
    mapping(uint256 => bool) private _allowed_amounts;
    mapping(uint256 => bool) private _allowed_amounts_stable;
    mapping(uint256 => bool) private _allowed_time_frames;
    IERC20 internal immutable DEXKIT =
        IERC20(0x4D0Def42Cf57D6f27CD4983042a55dce1C9F853c);
    uint256 constant HOLDING_BITT_MULTIPLIER = 200 * 10**18;
    uint256 constant HOLDING_KIT_MULTIPLIER = 50 * 10**18;

    constructor() {
        // 1INCH / USD
        _chainlink_feeds[0x443C5116CdF663Eb387e72C688D276e702135C87] = true;
        // AAVE / USD
        _chainlink_feeds[0x72484B12719E23115761D5DA1646945632979bB6] = true;
        // ADA / USD
        _chainlink_feeds[0x882554df528115a743c4537828DA8D5B58e52544] = true;

        // AGEUR / USD
        _chainlink_feeds[0x9b88d07B2354eF5f4579690356818e07371c7BeD] = true;

        // ALCX / USD
        _chainlink_feeds[0x5DB6e61B6159B20F068dc15A47dF2E5931b14f29] = true;
        // ALGO / USD
        _chainlink_feeds[0x03Bc6D9EFed65708D35fDaEfb25E87631a0a3437] = true;

        // ALPHA / USD
        _chainlink_feeds[0x289833F252eaB98582D62db94Bd75aB48AD9CF0D] = true;
        // APE / USD
        _chainlink_feeds[0x2Ac3F3Bfac8fC9094BC3f0F9041a51375235B992] = true;
        // AVAX / USD
        _chainlink_feeds[0xe01eA2fbd8D76ee323FbEd03eB9a8625EC981A10] = true;
        // AXS / USD
        _chainlink_feeds[0x9c371aE34509590E10aB98205d2dF5936A1aD875] = true;

        // BADGER / USD
        _chainlink_feeds[0xF626964Ba5e81405f47e8004F0b276Bb974742B5] = true;

        // BAL / USD
        _chainlink_feeds[0xD106B538F2A868c28Ca1Ec7E298C3325E0251d66] = true;
        // BAT / USD
        _chainlink_feeds[0x2346Ce62bd732c62618944E51cbFa09D985d86D2] = true;
        // BCH / USD
        _chainlink_feeds[0x327d9822e9932996f55b39F557AEC838313da8b7] = true;
        // BNB / USD
        _chainlink_feeds[0x82a6c4AF830caa6c97bb504425f6A66165C2c26e] = true;
        // BNT / USD
        _chainlink_feeds[0xF5724884b6E99257cC003375e6b844bC776183f9] = true;
        // BOND / USD
        _chainlink_feeds[0x58527C2dCC755297bB81f9334b80b2B6032d8524] = true;
        // BSV / USD
        _chainlink_feeds[0x8803DD6705F0d38e79790B02A2C43594A0538D22] = true;
        // BTC / USD
        _chainlink_feeds[0xc907E116054Ad103354f2D350FD2514433D57F6f] = true;
        // BTG / USD
        _chainlink_feeds[0x2f2C605F28DE314bc579a7c0FDf85536529E9825] = true;

        // CEL / USD
        _chainlink_feeds[0xc9ECF45956f576681bDc01F79602A79bC2667B0c] = true;

        // COMP  / USD
        _chainlink_feeds[0x2A8758b7257102461BC958279054e372C2b1bDE6] = true;
        // CRV  / USD
        _chainlink_feeds[0x336584C8E6Dc19637A5b36206B1c79923111b405] = true;

        // CTX / USD
        _chainlink_feeds[0xE039D4aA72A0C0d6d0218E650c1eBD6B2675A575] = true;
        // CVX / USD
        _chainlink_feeds[0x5ec151834040B4D453A1eA46aA634C1773b36084] = true;

        // DASH  / USD
        _chainlink_feeds[0xD94427eDee70E4991b4b8DdCc848f2B58ED01C0b] = true;

        // DGB / USD
        _chainlink_feeds[0x4205eC5fd179A843caa7B0860a8eC7D980013359] = true;
        // DODO / USD
        _chainlink_feeds[0x59161117086a4C7A9beDA16C66e40Bdaa1C5a8B6] = true;

        // DOGE  / USD
        _chainlink_feeds[0xbaf9327b6564454F4a3364C33eFeEf032b4b4444] = true;
        // DOT  / USD
        _chainlink_feeds[0xacb51F1a83922632ca02B25a8164c10748001BdE] = true;

        // EFI / USD
        _chainlink_feeds[0x392AcaA165a882dfC63D3aeB4c446b95Fa7013B0] = true;
        // ENJ / USD
        _chainlink_feeds[0x440A341bbC9FA86aA60A195e2409a547e48d4C0C] = true;

        // EOS  / USD
        _chainlink_feeds[0xd6285F06203D938ab713Fa6A315e7d23247DDE95] = true;
        // ETC  / USD
        _chainlink_feeds[0xDf3f72Be10d194b58B1BB56f2c4183e661cB2114] = true;
        // ETH  / USD
        _chainlink_feeds[0xF9680D99D6C9589e2a93a78A04A279e509205945] = true;

        // FARM  / USD
        _chainlink_feeds[0xDFb138ba3A6CCe675A6F5961323Be31eE42E40ff] = true;

        // FIS / USD
        _chainlink_feeds[0x18617D05eE1692Ad7EAFee9839459da16097AFd8] = true;
        // FTM / USD
        _chainlink_feeds[0x58326c0F831b2Dbf7234A4204F28Bba79AA06d5f] = true;
        // FTT / USD
        _chainlink_feeds[0x817A7D43f0277Ca480AE03Ec76Fc63A2EC7114bA] = true;

        // FXS  / USD
        _chainlink_feeds[0x6C0fe985D3cAcbCdE428b84fc9431792694d0f51] = true;

        // GHST / USD
        _chainlink_feeds[0xDD229Ce42f11D8Ee7fFf29bDB71C7b81352e11be] = true;
        // GNO / USD
        _chainlink_feeds[0x432fa0899cF1BcDb98592D7eAA23C372b8b8ddf2] = true;
        // GRT / USD
        _chainlink_feeds[0x3FabBfb300B1e2D7c9B84512fe9D30aeDF24C410] = true;
        // HBAR / USD
        _chainlink_feeds[0xC5878bDf8a89FA3bF0DC8389ae8EE6DE601D01bC] = true;

        // HT  / USD
        _chainlink_feeds[0x6F8F9e75C0285AecE30ADFe1BCc1955f145d971A] = true;
        // ICP  / USD
        _chainlink_feeds[0x84227A76a04289473057BEF706646199D7C58c34] = true;

        // KEEP / USD
        _chainlink_feeds[0x5438E60A06C7447432512264Fa57e2FeD3224b33] = true;
        // KLAY / USD
        _chainlink_feeds[0x86F87CB74238a6f24606534A2fCc05469Eb2bcF5] = true;

        // KNC  / USD
        _chainlink_feeds[0x10e5f3DFc81B3e5Ef4e648C4454D04e79E1E41E2] = true;

        // LINK  / USD
        _chainlink_feeds[0xd9FFdb71EbE7496cC440152d43986Aae0AB76665] = true;
        // LPT  / USD
        _chainlink_feeds[0xBAaF11CeDA1d1Ca9Cf01748F8196653c9656a400] = true;
        // LTC  / USD
        _chainlink_feeds[0xEB99F173cf7d9a6dC4D889C2Ad7103e8383b6Efa] = true;

        // MANA / USD
        _chainlink_feeds[0xA1CbF3Fe43BC3501e3Fc4b573e822c70e76A7512] = true;
        // MATIC / USD
        _chainlink_feeds[0xAB594600376Ec9fD91F8e885dADF0CE036862dE0] = true;
        // MFT / USD
        _chainlink_feeds[0x6E53C1c22427258BE55aE985a65c0C87BB631F9C] = true;

        // MIOTA / USD
        _chainlink_feeds[0x7d620D05c317A426903596432A5ca83375dC8d2A] = true;
        // MKR / USD /👉*Esse estava com o nome MIOTA mas é MKR*/
        _chainlink_feeds[0xa070427bF5bA5709f70e98b94Cb2F435a242C46C] = true;
        // NEO / USD
        _chainlink_feeds[0x74b3587A23eE786A43C8529c2e98D3C05a8fb1fB] = true;

        // NEXO / USD
        _chainlink_feeds[0x666bb13b3ED3816504E8c30D0F9B9C16b371774b] = true;
        // NU / USD
        _chainlink_feeds[0x1342a7a1D7264dAF8Ae790712266c7bE19f71211] = true;
        // OCEAN / USD
        _chainlink_feeds[0xdcda79097C44353Dee65684328793695bd34A629] = true;

        // OHM / USD
        _chainlink_feeds[0xa8B05B6337040c0529919BDB51f6B40A684eb08C] = true;

        // OHMv2 / USD
        _chainlink_feeds[0x4cE90F28C6357A7d3F47D680723d18AF3684cD00] = true;

        // OMG / USD
        _chainlink_feeds[0x93FfEE768F74208a7b9f2a4426f0F6BCbb1D09de] = true;

        // PAXG / USD
        _chainlink_feeds[0x0f6914d8e7e1214CDb3A4C6fbf729b75C69DF608] = true;

        // PICKLE / USD
        _chainlink_feeds[0xD3963855b73979B617455Fc38A7355563a289948] = true;
        // PLA / USD
        _chainlink_feeds[0x24C0e0FC8cCb21e2fb3e1A8A4eC4b29458664f79] = true;
        // POLY / USD
        _chainlink_feeds[0xC741F7752BAe936fCE97933b755884AF66fB69C1] = true;
        // QNT / USD
        _chainlink_feeds[0xDCc714619E59a626fde5f082d42F314E9fB832Fb] = true;

        // QUICK / USD
        _chainlink_feeds[0xa058689f4bCa95208bba3F265674AE95dED75B6D] = true;

        // RAI / USD
        _chainlink_feeds[0x7f45273fD7C644714825345670414Ea649b50b16] = true;

        // REP / USD
        _chainlink_feeds[0x634b084372f88848aC8F8006DC178aA810A58E89] = true;

        // RGT / USD
        _chainlink_feeds[0x3fCEf3eDF17f515d9c0fA72020FcFc6c0001F876] = true;
        // RLY / USD
        _chainlink_feeds[0x2E5B04aDC0A3b7dB5Fd34AE817c7D0993315A8a6] = true;

        // SAND / USD
        _chainlink_feeds[0x3D49406EDd4D52Fb7FFd25485f32E073b529C924] = true;

        // SHIB / USD
        _chainlink_feeds[0x3710abeb1A0Fc7C2EC59C26c8DAA7a448ff6125A] = true;
        // SLP / USD
        _chainlink_feeds[0xBB3eF70953fC3766bec4Ab7A9BF05B6E4caf89c6] = true;

        // SNX/ USD
        _chainlink_feeds[0xbF90A5D9B6EE9019028dbFc2a9E50056d5252894] = true;
        // SOL/ USD
        _chainlink_feeds[0x10C8264C0935b3B9870013e057f330Ff3e9C56dC] = true;

        // SRM / USD
        _chainlink_feeds[0xd8F8a7a38A1ac326312000d0a0218BF3216BfAbB] = true;

        // SUSHI/ USD
        _chainlink_feeds[0x49B0c695039243BBfEb8EcD054EB70061fd54aa0] = true;
        // THETA/ USD
        _chainlink_feeds[0x38611b09F8f2D520c14eA973765C225Bf57B9Eac] = true;

        // TOKE / USD
        _chainlink_feeds[0x9bce696Fb0DcE1ed4DDb94305757dEDc745f3786] = true;
        // TRIBE / USD
        _chainlink_feeds[0x346C7D75e315B54129eac38CC4e2B9f9b0250e3e] = true;
        // TRX / USD
        _chainlink_feeds[0x307cCF7cBD17b69A487b9C3dbe483931Cf3E1833] = true;

        // UMA/ USD
        _chainlink_feeds[0x33D9B1BAaDcF4b26ab6F8E83e9cb8a611B2B3956] = true;
        // UNI/ USD
        _chainlink_feeds[0xdf0Fb4e4F928d2dCB76f438575fDD8682386e13C] = true;

        // VET/ USD
        _chainlink_feeds[0xD78bc11ef3256e3CE9dC0DF0fa7be9E9afc07f95] = true;
        // WBTC/ USD
        _chainlink_feeds[0xDE31F8bFBD8c84b5360CFACCa3539B938dd78ae6] = true;

        // WOO / USD
        _chainlink_feeds[0x6a99EC84819FB7007dd5D032068742604E755c56] = true;

        // XLM/ USD
        _chainlink_feeds[0x692AE5510cA9070095A496dbcFBCDA99D4024Cd9] = true;
        // XMR/ USD
        _chainlink_feeds[0xBE6FB0AB6302B693368D0E9001fAF77ecc6571db] = true;
        // XRP/ USD
        _chainlink_feeds[0x785ba89291f676b5386652eB12b30cF361020694] = true;
        // XSUSHI/ USD
        _chainlink_feeds[0xC16Cb62CddE46f43Fd73257b957Bf527f07b51C0] = true;
        // XTZ/ USD
        _chainlink_feeds[0x691e26AB58ff05800E028b0876A41B720b26FC65] = true;
        // YFI/ USD
        _chainlink_feeds[0x9d3A43c111E7b2C6601705D9fcF7a70c95b1dc55] = true;
        // ZEC/ USD
        _chainlink_feeds[0xBC08c639e579a391C4228F20d0C29d0690092DF0] = true;
        // ZRX/ USD
        _chainlink_feeds[0x6EA4d89474d9410939d429B786208c74853A5B47] = true;

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
            0xc2132D05D31c914a87C6611C10748AEb04B58e8F
        ] = true;
        _allowed_coins_to_play[
            0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        ] = true;

        // Allowed Amounts Stable: Tether has 6 decimals on MATIC
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
        if (DEXKIT.balanceOf(msg.sender) >= HOLDING_KIT_MULTIPLIER) {
            return int256(1200);
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
            int256(1550),
            int256(1500),
            int256(1450),
            int256(1400),
            int256(1350)
        ];
    }
}
