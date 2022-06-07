//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/ICoinLeagueSettings.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// stores all settings of game
contract CoinLeagueSettingsBNB is ICoinLeagueSettings {
    mapping(address => bool) private _chainlink_feeds;
    mapping(uint256 => bool) private _allowed_amount_players;
    mapping(uint256 => bool) private _allowed_amount_coins;
    mapping(uint256 => bool) private _allowed_amounts;
    mapping(uint256 => bool) private _allowed_time_frames;
    IERC20 internal immutable BITTOKEN =
        IERC20(0x518445F0dB93863E5e93A7F70617c05AFa8048f1);
    IERC20 internal immutable DEXKIT =
        IERC20(0x314593fa9a2fa16432913dBcCC96104541d32D11);
    uint256 constant HOLDING_BITT_MULTIPLIER = 200 * 10**18;
    uint256 constant HOLDING_KIT_MULTIPLIER = 50 * 10**18;

    constructor() {
               
        // BSC Mainnet
        // AAVE / USD
         _chainlink_feeds[0xA8357BF572460fC40f4B0aCacbB2a6A61c89f475] = true;
         // ADA / USD
         _chainlink_feeds[0xa767f745331D267c7751297D982b050c93985627] = true;
         // ALPACA / USD
         _chainlink_feeds[0xe0073b60833249ffd1bb2af809112c2fbf221DF6] = true;
         // AMZN / USD
        // _chainlink_feeds[0x51d08ca89d3e8c12535BA8AEd33cDf2557ab5b2a] = true;
         // ARKK / USD
        // _chainlink_feeds[0x234c7a1da64Bdf44E1B8A25C94af53ff2A199dE0] = true;
         // ATOM / USD
         _chainlink_feeds[0xb056B7C804297279A9a673289264c17E6Dc6055d] = true;
         // AUTO / USD
         _chainlink_feeds[0x88E71E6520E5aC75f5338F5F0c9DeD9d4f692cDA] = true;
         // AXS / USD
         _chainlink_feeds[0x7B49524ee5740c99435f52d731dFC94082fE61Ab] = true;
         // BAC / USD
         _chainlink_feeds[0x368b7ab0a0Ff94E23fF5e4A7F04327dF7079E174] = true;
         // BAND / USD
         _chainlink_feeds[0xC78b99Ae87fF43535b0C782128DB3cB49c74A4d3] = true;
         // BCH / USD
         _chainlink_feeds[0x43d80f616DAf0b0B42a928EeD32147dC59027D41] = true;
         // BETH / USD
      //   _chainlink_feeds[0x2A3796273d47c4eD363b361D3AEFb7F7E2A13782] = true;
         // BIDU / USD
        // _chainlink_feeds[0xb9344e4Ffa6d5885B2C5830adc27ddF3FdBF883c] = true;
         // BIFI / USD
         _chainlink_feeds[0xaB827b69daCd586A37E80A7d552a4395d576e645] = true;
         // BNB / USD
         _chainlink_feeds[0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE] = true;
         // BRK.B / USD
        // _chainlink_feeds[0x5289A08b6d5D2f8fAd4cC169c65177f68C0f0A99] = true;
         // BTC / USD
         _chainlink_feeds[0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf] = true;
        // BUSD / USD
        // _chainlink_feeds[0xcBb98864Ef56E9042e7d2efef76141f15731B82f] = true;
         // BZRX / USD
        // _chainlink_feeds[0xFc362828930519f236ad0c8f126B7996562a695A] = true;
         // CAKE / USD
         _chainlink_feeds[0xB6064eD41d4f67e353768aA239cA86f4F73665a1] = true;
         // CFX / USD
         _chainlink_feeds[0xe3cA2f3Bad1D8327820f648C759f17162b5383ae] = true;
         // CHF / USD
        // _chainlink_feeds[0x964261740356cB4aaD0C3D2003Ce808A4176a46d] = true;
         // CHR / USD
         _chainlink_feeds[0x1f771B2b1F3c3Db6C7A1d5F38961a49CEcD116dA] = true;
         // COIN / USD
        // _chainlink_feeds[0x2d1AB79D059e21aE519d88F978cAF39d74E31AEB] = true;
         // COMP / USD
         _chainlink_feeds[0x0Db8945f9aEf5651fa5bd52314C5aAe78DfDe540] = true;
         // CREAM / USD
         _chainlink_feeds[0xa12Fc27A873cf114e6D8bBAf8BD9b8AC56110b39] = true;
         // DAI / USD
      //   _chainlink_feeds[0x132d3C0B1D2cEa0BC552588063bdBb210FDeecfA] = true;
         // DEGO / USD
         _chainlink_feeds[0x39F1275366D130eB677D4F47D40F9296B62D877A] = true;
         // DF / USD
         _chainlink_feeds[0x1b816F5E122eFa230300126F97C018716c4e47F5] = true;
         // DODO / USD
         _chainlink_feeds[0x87701B15C08687341c2a847ca44eCfBc8d7873E1] = true;
         // DOGE / USD
         _chainlink_feeds[0x3AB0A0d137D4F946fBB19eecc6e92E64660231C8] = true;
         // DOT / USD
         _chainlink_feeds[0xC333eb0086309a16aa7c8308DfD32c8BBA0a2592] = true;
          // DPI / USD
         _chainlink_feeds[0x7ee7E7847FFC93F8Cf67BCCc0002afF9C52DE524] = true;
          // EOS / USD
         _chainlink_feeds[0xd5508c8Ffdb8F15cE336e629fD4ca9AdB48f50F0] = true;
          // ETH / USD
         _chainlink_feeds[0x9ef1B8c0E4F7dc8bF5719Ea496883DC6401d5b2e] = true;
          // EUR / USD
         // _chainlink_feeds[0x0bf79F617988C472DcA68ff41eFe1338955b9A80] = true;
          // FB / USD
         _chainlink_feeds[0xfc76E9445952A3C31369dFd26edfdfb9713DF5Bb] = true;
          // FET / USD
         _chainlink_feeds[0x657e700c66C48c135c4A29c4292908DbdA7aa280] = true;
          // FIL / USD
         _chainlink_feeds[0xE5dbFD9003bFf9dF5feB2f4F445Ca00fb121fb83] = true;
          // GBP / USD
      //   _chainlink_feeds[0x8FAf16F710003E538189334541F5D4a391Da46a0] = true;
          // GME / USD
        // _chainlink_feeds[0x66cD2975d02f5F5cdEF2E05cBca12549B1a5022D] = true;
          // GOOGL / USD
         // _chainlink_feeds[0xeDA73F8acb669274B15A977Cb0cdA57a84F18c2a] = true;
          // ICP / USD
         _chainlink_feeds[0x84210d9013A30C6ab169e28840A6CC54B60fa042] = true;
          // INJ / USD
         _chainlink_feeds[0x63A9133cd7c611d6049761038C16f238FddA71d7] = true;
          // JPM / USD
       //  _chainlink_feeds[0x8f26ba94180371baA2D2C143f96b6886DCACA250] = true;
          // LINA / USD
         _chainlink_feeds[0x38393201952f2764E04B290af9df427217D56B41] = true;
          // LINK / USD
         _chainlink_feeds[0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8] = true;
          // LIT / USD
         _chainlink_feeds[0x83766bA8d964fEAeD3819b145a69c947Df9Cb035] = true;
          // LTC / USD
         _chainlink_feeds[0x74E72F37A8c415c8f1a98Ed42E78Ff997435791D] = true;
          // MASK / USD
         _chainlink_feeds[0x4978c0abE6899178c1A74838Ee0062280888E2Cf] = true;
         // MATIC / USD
         _chainlink_feeds[0x7CA57b0cA6367191c94C8914d7Df09A57655905f] = true;
         // MIM / USD
         _chainlink_feeds[0xc9D267542B23B41fB93397a93e5a1D7B80Ea5A01] = true;
         // MIR / USD
         _chainlink_feeds[0x291B2983b995870779C36A102Da101f8765244D6] = true;
         // MRNA / USD 
         _chainlink_feeds[0x6101F4DFBb24Cac3D64e28A815255B428b93639f] = true;
         // MS / USD
       //  _chainlink_feeds[0x6b25F7f189c3f26d3caC43b754578b67Fc8d952A] = true;
         // MSFT / USD
        // _chainlink_feeds[0x5D209cE1fBABeAA8E6f9De4514A74FFB4b34560F] = true;
         // NFLX / USD
         _chainlink_feeds[0x1fE6c9Bd9B29e5810c2819f37dDa8559739ebeC9] = true;
         // NGN / USD
       //  _chainlink_feeds[0x1FF2B48ed0A1669d6CcC83f4B3c84FDdF13Ea594] = true;
         // NULS / USD
         _chainlink_feeds[0xaCFBE73231d312AC6954496b3f786E892bF0f7e5] = true;
         // NVDA / USD
       //  _chainlink_feeds[0xea5c2Cbb5cD57daC24E26180b19a929F3E9699B8] = true;
         // ONT / USD
         _chainlink_feeds[0x887f177CBED2cf555a64e7bF125E1825EB69dB82] = true;
         // PACB / USD
      //   _chainlink_feeds[0xe9bEC24f14AB49b0a81a482a4224e7505d2d29e9] = true;
         // PAXG / USD
         _chainlink_feeds[0x7F8caD4690A38aC28BDA3D132eF83DB1C17557Df] = true;
         // PFE / USD
         _chainlink_feeds[0xe96fFdE2ba50E0e869520475ee1bC73cA2dEE326] = true;
         // QQQ / USD
        // _chainlink_feeds[0x9A41B56b2c24683E2f23BdE15c14BC7c4a58c3c4] = true;
         // RAMP / USD
         _chainlink_feeds[0xD1225da5FC21d17CaE526ee4b6464787c6A71b4C] = true;
          // REEF / USD
         _chainlink_feeds[0x46f13472A4d4FeC9E07E8A00eE52f4Fa77810736] = true;
          // SOL / USD
         _chainlink_feeds[0x0E8a53DD9c13589df6382F13dA6B3Ec8F919B323] = true;
          // SPCE / USD
         _chainlink_feeds[0xC861a351b2b50985b9061a5b68EBF9018e7FfB7b] = true;
          // SPELL / USD
         _chainlink_feeds[0x47e01580C537Cd47dA339eA3a4aFb5998CCf037C] = true;
          // SPY / USD
         _chainlink_feeds[0xb24D1DeE5F9a3f761D286B56d2bC44CE1D02DF7e] = true;
          // SUSHI / USD
         _chainlink_feeds[0xa679C72a97B654CFfF58aB704de3BA15Cde89B07] = true;
          // SXP / USD
         _chainlink_feeds[0xE188A9875af525d25334d75F3327863B2b8cd0F1] = true;
          // TRX / USD
         _chainlink_feeds[0xF4C5e535756D11994fCBB12Ba8adD0192D9b88be] = true;
          // TSLA / USD
        // _chainlink_feeds[0xEEA2ae9c074E87596A85ABE698B2Afebc9B57893] = true;
          // TSM / USD
         _chainlink_feeds[0x685fC5acB74CE3d5DF03543c9813C73DFCe50de8] = true;
          // TUSD / USD
       //  _chainlink_feeds[0xa3334A9762090E827413A7495AfeCE76F41dFc06] = true;
          // UNH / USD
         _chainlink_feeds[0xC18c5A32c84CbbAc7D0F06Dd370198DA711c73C9] = true;
         // UNI / USD
         _chainlink_feeds[0xb57f259E7C24e56a1dA00F66b55A5640d9f9E7e4] = true;
         // VAI / USD
         _chainlink_feeds[0x058316f8Bb13aCD442ee7A216C7b60CFB4Ea1B53] = true;
         // VT / USD
         _chainlink_feeds[0xa3D5BB7e8ccc2Dc7492537cc2Ec4e4E7BBA32fa0] = true;
         // WING / USD
         _chainlink_feeds[0xf7E7c0ffCB11dAC6eCA1434C67faB9aE000e10a7] = true;
         // WOO / USD
         _chainlink_feeds[0x02Bfe714e78E2Ad1bb1C2beE93eC8dc5423B66d4] = true;
         // WTI / USD
         _chainlink_feeds[0xb1BED6C1fC1adE2A975F54F24851c7F410e27718] = true;
         // XAG / USD
         _chainlink_feeds[0x817326922c909b16944817c207562B25C4dF16aD] = true;
         // XAU / USD
         _chainlink_feeds[0x86896fEB19D8A607c3b11f2aF50A0f239Bd71CD0] = true;
         // XRP / USD
         _chainlink_feeds[0x93A67D414896A280bF8FFB3b389fE3686E014fda] = true;
         // XTZ / USD
         _chainlink_feeds[0x9A18137ADCF7b05f033ad26968Ed5a9cf0Bf8E6b] = true;
         // XVS / USD
         _chainlink_feeds[0xBF63F430A79D4036A5900C19818aFf1fa710f206] = true;
         // YFI / USD
         _chainlink_feeds[0xD7eAa5Bf3013A96e3d515c055Dbd98DbdC8c620D] = true;
         // YFII / USD
         _chainlink_feeds[0xC94580FAaF145B2FD0ab5215031833c98D3B77E4] = true;
         // ZIL / USD
         _chainlink_feeds[0x3e3aA4FC329529C8Ab921c810850626021dbA7e6] = true;
         // ONG / USD
         _chainlink_feeds[0xcF95796f3016801A1dA5C518Fc7A59C51dcEf793] = true;
         // SHIB / USD  
         _chainlink_feeds[0xA615Be6cb0f3F36A641858dB6F30B9242d0ABeD8] = true;
         // XLM / USD
         _chainlink_feeds[0x27Cc356A5891A3Fe6f84D0457dE4d108C6078888] = true;
             

        // Allowed Amounts
        _allowed_amounts[0.0001 ether] = true;
        _allowed_amounts[0.01 ether] = true;
        _allowed_amounts[0.05 ether] = true;
        _allowed_amounts[0.1 ether] = true;
        _allowed_amounts[0.3 ether] = true;
        _allowed_amounts[1 ether] = true;
        _allowed_amounts[3 ether] = true;
        _allowed_amounts[5 ether] = true;
        _allowed_amounts[10 ether] = true;
        _allowed_amounts[25 ether] = true;
        _allowed_amounts[50 ether] = true;
        _allowed_amounts[250 ether] = true;
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
        _allowed_amount_coins[10] = true;
        // Allowed Time Frames
        _allowed_time_frames[60 * 5] = true;
        _allowed_time_frames[60 * 60] = true;
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
        if (
            BITTOKEN.balanceOf(msg.sender) >= HOLDING_BITT_MULTIPLIER ||
            DEXKIT.balanceOf(msg.sender) >= HOLDING_KIT_MULTIPLIER
        ) {
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
            int256(1000),
            int256(1000),
            int256(1000),
            int256(1000),
            int256(1000),
            int256(1000),
            int256(1000),
            int256(1000)
        ];
    }
}
