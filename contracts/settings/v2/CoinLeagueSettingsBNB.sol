//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../../interfaces/ICoinLeagueSettingsV2.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// stores all settings of game
contract CoinLeagueSettingsV2BNB is ICoinLeagueSettingsV2 {
    mapping(address => bool) private _chainlink_feeds;
    mapping(uint256 => bool) private _allowed_amount_players;
    mapping(uint256 => bool) private _allowed_amount_coins;
    mapping(address => bool) private _allowed_coins_to_play;
    mapping(uint256 => bool) private _allowed_amounts;
    mapping(uint256 => bool) private _allowed_amounts_stable;
    mapping(uint256 => bool) private _allowed_time_frames;

    IERC20 internal immutable DEXKIT =
        IERC20(0x314593fa9a2fa16432913dBcCC96104541d32D11);
    uint256 constant HOLDING_KIT_MULTIPLIER = 50 * 10**18;

    constructor() {
        // BSC Mainnet

        // 1INCH/USD: 0x9a177Bb9f5b6083E962f9e62bD21d4b5660Aeb03
        _chainlink_feeds[0x9a177Bb9f5b6083E962f9e62bD21d4b5660Aeb03] = true;

        // AAVE/USD: 0xA8357BF572460fC40f4B0aCacbB2a6A61c89f475
        _chainlink_feeds[0xA8357BF572460fC40f4B0aCacbB2a6A61c89f475] = true;

        // AAVE Network Emergency Count: 0xcabb46FfB38c93348Df16558DF156e9f68F9F7F1
        _chainlink_feeds[0xcabb46FfB38c93348Df16558DF156e9f68F9F7F1] = true;

        // ADA/BNB: 0x2d5Fc41d1365fFe13d03d91E82e04Ca878D69f4B
        _chainlink_feeds[0x2d5Fc41d1365fFe13d03d91E82e04Ca878D69f4B] = true;

        // ADA/USD: 0xa767f745331D267c7751297D982b050c93985627
        _chainlink_feeds[0xa767f745331D267c7751297D982b050c93985627] = true;

        // ALPACA/USD: 0xe0073b60833249ffd1bb2af809112c2fbf221DF6
        _chainlink_feeds[0xe0073b60833249ffd1bb2af809112c2fbf221DF6] = true;

        // ASTER/USD: 0x3ae518be05e3F7faBf7e3Ace22Af795D7A09c2E5
        _chainlink_feeds[0x3ae518be05e3F7faBf7e3Ace22Af795D7A09c2E5] = true;

        // ATOM/USD: 0xb056B7C804297279A9a673289264c17E6Dc6055d
        _chainlink_feeds[0xb056B7C804297279A9a673289264c17E6Dc6055d] = true;

        // AUTO/USD: 0x88E71E6520E5aC75f5338F5F0c9DeD9d4f692cDA
        _chainlink_feeds[0x88E71E6520E5aC75f5338F5F0c9DeD9d4f692cDA] = true;

        // AVAX/USD: 0x5974855ce31EE8E1fff2e76591CbF83D7110F151
        _chainlink_feeds[0x5974855ce31EE8E1fff2e76591CbF83D7110F151] = true;

        // AXS/USD: 0x7B49524ee5740c99435f52d731dFC94082fE61Ab
        _chainlink_feeds[0x7B49524ee5740c99435f52d731dFC94082fE61Ab] = true;

        // BAC/USD: 0x368b7ab0a0Ff94E23fF5e4A7F04327dF7079E174
        _chainlink_feeds[0x368b7ab0a0Ff94E23fF5e4A7F04327dF7079E174] = true;

        // BAND/BNB: 0x3334bF7ec892Ca03D1378B51769b7782EAF318C4
        _chainlink_feeds[0x3334bF7ec892Ca03D1378B51769b7782EAF318C4] = true;

        // BAND/USD: 0xC78b99Ae87fF43535b0C782128DB3cB49c74A4d3
        _chainlink_feeds[0xC78b99Ae87fF43535b0C782128DB3cB49c74A4d3] = true;

        // BCH/BNB: 0x2a548935a323Bb7329a5E3F1667B979f16Bc890b
        _chainlink_feeds[0x2a548935a323Bb7329a5E3F1667B979f16Bc890b] = true;

        // BCH/USD: 0x43d80f616DAf0b0B42a928EeD32147dC59027D41
        _chainlink_feeds[0x43d80f616DAf0b0B42a928EeD32147dC59027D41] = true;

        // BIFI/USD: 0xaB827b69daCd586A37E80A7d552a4395d576e645
        _chainlink_feeds[0xaB827b69daCd586A37E80A7d552a4395d576e645] = true;

        // BNB/USD: 0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE
        _chainlink_feeds[0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE] = true;

        // BR/USD: 0x90d36D4909730c390546ac288c5C7bEc3f62FF4D
        _chainlink_feeds[0x90d36D4909730c390546ac288c5C7bEc3f62FF4D] = true;

        // BTC/BNB: 0x116EeB23384451C78ed366D4f67D5AD44eE771A0
        _chainlink_feeds[0x116EeB23384451C78ed366D4f67D5AD44eE771A0] = true;

        // BTC/ETH: 0xf1769eB4D1943AF02ab1096D7893759F6177D6B8
        _chainlink_feeds[0xf1769eB4D1943AF02ab1096D7893759F6177D6B8] = true;

        // BTC/USD: 0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf
        _chainlink_feeds[0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf] = true;

        // C98/USD: 0x889158E39628C0397DC54B84F6b1cbe0AaEb7FFc
        _chainlink_feeds[0x889158E39628C0397DC54B84F6b1cbe0AaEb7FFc] = true;

        // CAKE/BNB: 0xcB23da9EA243f53194CBc2380A6d4d9bC046161f
        _chainlink_feeds[0xcB23da9EA243f53194CBc2380A6d4d9bC046161f] = true;

        // CAKE/USD: 0xB6064eD41d4f67e353768aA239cA86f4F73665a1
        _chainlink_feeds[0xB6064eD41d4f67e353768aA239cA86f4F73665a1] = true;

        // Calculated BNBx/USD: 0xc4429B539397a3166eF3ef132c29e34715a3ABb4
        _chainlink_feeds[0xc4429B539397a3166eF3ef132c29e34715a3ABb4] = true;

        // Calculated SAVAX/USD: 0x3b37C6f1e3207DE5a4664E837072Bd9A25269B39
        _chainlink_feeds[0x3b37C6f1e3207DE5a4664E837072Bd9A25269B39] = true;

        // CFX/USD: 0xe3cA2f3Bad1D8327820f648C759f17162b5383ae
        _chainlink_feeds[0xe3cA2f3Bad1D8327820f648C759f17162b5383ae] = true;

        // CHR/USD: 0x1f771B2b1F3c3Db6C7A1d5F38961a49CEcD116dA
        _chainlink_feeds[0x1f771B2b1F3c3Db6C7A1d5F38961a49CEcD116dA] = true;

        // COMP/USD: 0x0Db8945f9aEf5651fa5bd52314C5aAe78DfDe540
        _chainlink_feeds[0x0Db8945f9aEf5651fa5bd52314C5aAe78DfDe540] = true;

        // CREAM/USD: 0xa12Fc27A873cf114e6D8bBAf8BD9b8AC56110b39
        _chainlink_feeds[0xa12Fc27A873cf114e6D8bBAf8BD9b8AC56110b39] = true;

        // CRV/USD: 0x2e1C3b6Fcae47b20Dd343D9354F7B1140a1E6B27
        _chainlink_feeds[0x2e1C3b6Fcae47b20Dd343D9354F7B1140a1E6B27] = true;

        // DAI/BNB: 0x8EC213E7191488C7873cEC6daC8e97cdbAdb7B35
        _chainlink_feeds[0x8EC213E7191488C7873cEC6daC8e97cdbAdb7B35] = true;

        // DAI/USD: 0x132d3C0B1D2cEa0BC552588063bdBb210FDeecfA
        _chainlink_feeds[0x132d3C0B1D2cEa0BC552588063bdBb210FDeecfA] = true;

        // DEGO/USD: 0x39F1275366D130eB677D4F47D40F9296B62D877A
        _chainlink_feeds[0x39F1275366D130eB677D4F47D40F9296B62D877A] = true;

        // DF/USD: 0x1b816F5E122eFa230300126F97C018716c4e47F5
        _chainlink_feeds[0x1b816F5E122eFa230300126F97C018716c4e47F5] = true;

        // DODO/USD: 0x87701B15C08687341c2a847ca44eCfBc8d7873E1
        _chainlink_feeds[0x87701B15C08687341c2a847ca44eCfBc8d7873E1] = true;

        // DOGE/USD: 0x3AB0A0d137D4F946fBB19eecc6e92E64660231C8
        _chainlink_feeds[0x3AB0A0d137D4F946fBB19eecc6e92E64660231C8] = true;

        // DOT/BNB: 0xBA8683E9c3B1455bE6e18E7768e8cAD95Eb5eD49
        _chainlink_feeds[0xBA8683E9c3B1455bE6e18E7768e8cAD95Eb5eD49] = true;

        // DOT/USD: 0xC333eb0086309a16aa7c8308DfD32c8BBA0a2592
        _chainlink_feeds[0xC333eb0086309a16aa7c8308DfD32c8BBA0a2592] = true;

        // DPI/USD: 0x7ee7E7847FFC93F8Cf67BCCc0002afF9C52DE524
        _chainlink_feeds[0x7ee7E7847FFC93F8Cf67BCCc0002afF9C52DE524] = true;

        // EOS/USD: 0xd5508c8Ffdb8F15cE336e629fD4ca9AdB48f50F0
        _chainlink_feeds[0xd5508c8Ffdb8F15cE336e629fD4ca9AdB48f50F0] = true;

        // ETH/BNB: 0x63D407F32Aa72E63C7209ce1c2F5dA40b3AaE726
        _chainlink_feeds[0x63D407F32Aa72E63C7209ce1c2F5dA40b3AaE726] = true;

        // ETH/USD: 0x9ef1B8c0E4F7dc8bF5719Ea496883DC6401d5b2e
        _chainlink_feeds[0x9ef1B8c0E4F7dc8bF5719Ea496883DC6401d5b2e] = true;

        // ezETH/ETH Exchange Rate: 0x06F34EdD61Be3b2Ff3F630B500dF81eeA8312350
        _chainlink_feeds[0x06F34EdD61Be3b2Ff3F630B500dF81eeA8312350] = true;

        // FB/USD: 0xfc76E9445952A3C31369dFd26edfdfb9713DF5Bb
        _chainlink_feeds[0xfc76E9445952A3C31369dFd26edfdfb9713DF5Bb] = true;

        // FDUSD/USD: 0x390180e80058A8499930F0c13963AD3E0d86Bfc9
        _chainlink_feeds[0x390180e80058A8499930F0c13963AD3E0d86Bfc9] = true;

        // FET/USD: 0x657e700c66C48c135c4A29c4292908DbdA7aa280
        _chainlink_feeds[0x657e700c66C48c135c4A29c4292908DbdA7aa280] = true;

        // FIL/USD: 0xE5dbFD9003bFf9dF5feB2f4F445Ca00fb121fb83
        _chainlink_feeds[0xE5dbFD9003bFf9dF5feB2f4F445Ca00fb121fb83] = true;

        // FRAX/USD: 0x13A9c98b07F098c5319f4FF786eB16E22DC738e1
        _chainlink_feeds[0x13A9c98b07F098c5319f4FF786eB16E22DC738e1] = true;

        // FXS/USD: 0x0E9D55932893Fb1308882C7857285B2B0bcc4f4a
        _chainlink_feeds[0x0E9D55932893Fb1308882C7857285B2B0bcc4f4a] = true;

        // GMT/USD: 0x8b0D36ae4CF8e277773A7ba5F35c09Edb144241b
        _chainlink_feeds[0x8b0D36ae4CF8e277773A7ba5F35c09Edb144241b] = true;

        // HIGH/USD: 0xdF4Dd957a84F798acFADd448badd2D8b9bC99047
        _chainlink_feeds[0xdF4Dd957a84F798acFADd448badd2D8b9bC99047] = true;

        // ICP/USD: 0x84210d9013A30C6ab169e28840A6CC54B60fa042
        _chainlink_feeds[0x84210d9013A30C6ab169e28840A6CC54B60fa042] = true;

        // INJ/USD: 0x63A9133cd7c611d6049761038C16f238FddA71d7
        _chainlink_feeds[0x63A9133cd7c611d6049761038C16f238FddA71d7] = true;

        // KAVA/USD: 0x12bf0C3f7D5aca9E711930d704dA2774358d9210
        _chainlink_feeds[0x12bf0C3f7D5aca9E711930d704dA2774358d9210] = true;

        // KNC/USD: 0xF2f8273F6b9Fc22C90891DC802cAf60eeF805cDF
        _chainlink_feeds[0xF2f8273F6b9Fc22C90891DC802cAf60eeF805cDF] = true;

        // LBTC/BTC: 0x41A292Dced910690b86b99A6cbC2e181dc56De57
        _chainlink_feeds[0x41A292Dced910690b86b99A6cbC2e181dc56De57] = true;

        // LINA/USD: 0x38393201952f2764E04B290af9df427217D56B41
        _chainlink_feeds[0x38393201952f2764E04B290af9df427217D56B41] = true;

        // LINK/BNB: 0xB38722F6A608646a538E882Ee9972D15c86Fc597
        _chainlink_feeds[0xB38722F6A608646a538E882Ee9972D15c86Fc597] = true;

        // LINK/USD: 0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8
        _chainlink_feeds[0xca236E327F629f9Fc2c30A4E95775EbF0B89fac8] = true;

        // LIT/USD: 0x83766bA8d964fEAeD3819b145a69c947Df9Cb035
        _chainlink_feeds[0x83766bA8d964fEAeD3819b145a69c947Df9Cb035] = true;

        // LISTA/USD: 0x801A72542E6F2c1A022eC6865600D6872b191308
        _chainlink_feeds[0x801A72542E6F2c1A022eC6865600D6872b191308] = true;

        // LTC/BNB: 0x4e5a43A79f53c0a8e83489648Ea7e429278f8b2D
        _chainlink_feeds[0x4e5a43A79f53c0a8e83489648Ea7e429278f8b2D] = true;

        // LTC/USD: 0x74E72F37A8c415c8f1a98Ed42E78Ff997435791D
        _chainlink_feeds[0x74E72F37A8c415c8f1a98Ed42E78Ff997435791D] = true;

        // MASK/USD: 0x4978c0abE6899178c1A74838Ee0062280888E2Cf
        _chainlink_feeds[0x4978c0abE6899178c1A74838Ee0062280888E2Cf] = true;

        // MATIC/USD: 0x7CA57b0cA6367191c94C8914d7Df09A57655905f
        _chainlink_feeds[0x7CA57b0cA6367191c94C8914d7Df09A57655905f] = true;

        // MIM/USD: 0xc9D267542B23B41fB93397a93e5a1D7B80Ea5A01
        _chainlink_feeds[0xc9D267542B23B41fB93397a93e5a1D7B80Ea5A01] = true;

        // MIR/USD: 0x291B2983b995870779C36A102Da101f8765244D6
        _chainlink_feeds[0x291B2983b995870779C36A102Da101f8765244D6] = true;

        // MRNA/USD: 0x6101F4DFBb24Cac3D64e28A815255B428b93639f
        _chainlink_feeds[0x6101F4DFBb24Cac3D64e28A815255B428b93639f] = true;

        // MUSD/USD: 0xE9736eB458b0741e781E460228b9e5291488F7cE
        _chainlink_feeds[0xE9736eB458b0741e781E460228b9e5291488F7cE] = true;

        // NEAR/USD: 0x0Fe4D87883005fCAFaF56B81d09473D9A29dCDC3
        _chainlink_feeds[0x0Fe4D87883005fCAFaF56B81d09473D9A29dCDC3] = true;

        // NFLX/USD: 0x1fE6c9Bd9B29e5810c2819f37dDa8559739ebeC9
        _chainlink_feeds[0x1fE6c9Bd9B29e5810c2819f37dDa8559739ebeC9] = true;

        // NULS/USD: 0xaCFBE73231d312AC6954496b3f786E892bF0f7e5
        _chainlink_feeds[0xaCFBE73231d312AC6954496b3f786E892bF0f7e5] = true;

        // ONG/USD: 0xcF95796f3016801A1dA5C518Fc7A59C51dcEf793
        _chainlink_feeds[0xcF95796f3016801A1dA5C518Fc7A59C51dcEf793] = true;

        // ONT/USD: 0x887f177CBED2cf555a64e7bF125E1825EB69dB82
        _chainlink_feeds[0x887f177CBED2cf555a64e7bF125E1825EB69dB82] = true;

        // PAXG/USD: 0x7F8caD4690A38aC28BDA3D132eF83DB1C17557Df
        _chainlink_feeds[0x7F8caD4690A38aC28BDA3D132eF83DB1C17557Df] = true;

        // PFE/USD: 0xe96fFdE2ba50E0e869520475ee1bC73cA2dEE326
        _chainlink_feeds[0xe96fFdE2ba50E0e869520475ee1bC73cA2dEE326] = true;

        // POL/USD: 0x081195B56674bb87b2B92F6D58F7c5f449aCE19d
        _chainlink_feeds[0x081195B56674bb87b2B92F6D58F7c5f449aCE19d] = true;

        // RAMP/USD: 0xD1225da5FC21d17CaE526ee4b6464787c6A71b4C
        _chainlink_feeds[0xD1225da5FC21d17CaE526ee4b6464787c6A71b4C] = true;

        // RDNT/USD: 0x20123C6ebd45c6496102BeEA86e1a6616Ca547c6
        _chainlink_feeds[0x20123C6ebd45c6496102BeEA86e1a6616Ca547c6] = true;

        // REEF/USD: 0x46f13472A4d4FeC9E07E8A00eE52f4Fa77810736
        _chainlink_feeds[0x46f13472A4d4FeC9E07E8A00eE52f4Fa77810736] = true;

        // savBTC/avBTC Exchange Rate: 0x14Ae6B76cd940Fa449381cdC9f3a098A3D39A730
        _chainlink_feeds[0x14Ae6B76cd940Fa449381cdC9f3a098A3D39A730] = true;

        // SAVUSD/AVUSD Exchange Rate: 0xCA9112fC543C662F857A5f949585Fe054933cD72
        _chainlink_feeds[0xCA9112fC543C662F857A5f949585Fe054933cD72] = true;

        // SHIB/USD: 0xA615Be6cb0f3F36A641858dB6F30B9242d0ABeD8
        _chainlink_feeds[0xA615Be6cb0f3F36A641858dB6F30B9242d0ABeD8] = true;

        // SOL/USD: 0x0E8a53DD9c13589df6382F13dA6B3Ec8F919B323
        _chainlink_feeds[0x0E8a53DD9c13589df6382F13dA6B3Ec8F919B323] = true;

        // solvBTC/BTC: 0xf93b9B23c46331704EC550c24CB4110975057863
        _chainlink_feeds[0xf93b9B23c46331704EC550c24CB4110975057863] = true;

        // SolvBTC.BBN/SolvBTC Exchange Rate: 0x601CaA447C59Dc4E25992f4057BbE828F66193C0
        _chainlink_feeds[0x601CaA447C59Dc4E25992f4057BbE828F66193C0] = true;

        // SPCE/USD: 0xC861a351b2b50985b9061a5b68EBF9018e7FfB7b
        _chainlink_feeds[0xC861a351b2b50985b9061a5b68EBF9018e7FfB7b] = true;

        // SPELL/USD: 0x47e01580C537Cd47dA339eA3a4aFb5998CCf037C
        _chainlink_feeds[0x47e01580C537Cd47dA339eA3a4aFb5998CCf037C] = true;

        // SPY/USD: 0xb24D1DeE5F9a3f761D286B56d2bC44CE1D02DF7e
        _chainlink_feeds[0xb24D1DeE5F9a3f761D286B56d2bC44CE1D02DF7e] = true;

        // STONE/ETH Exchange Rate: 0xC6A1314E89d01517a90AE4b0d9d5e499A324B283
        _chainlink_feeds[0xC6A1314E89d01517a90AE4b0d9d5e499A324B283] = true;

        // SUSDE/USDE Exchange Rate: 0x1a269eA1b209DA2c12bDCDab22635C9e6C5028B2
        _chainlink_feeds[0x1a269eA1b209DA2c12bDCDab22635C9e6C5028B2] = true;

        // sUSDf/USDf Exchange Rate: 0xdC7eA2fa4068d135D7A7a9f3583f674c34eF114a
        _chainlink_feeds[0xdC7eA2fa4068d135D7A7a9f3583f674c34eF114a] = true;

        // SUSHI/USD: 0xa679C72a97B654CFfF58aB704de3BA15Cde89B07
        _chainlink_feeds[0xa679C72a97B654CFfF58aB704de3BA15Cde89B07] = true;

        // SXP/USD: 0xE188A9875af525d25334d75F3327863B2b8cd0F1
        _chainlink_feeds[0xE188A9875af525d25334d75F3327863B2b8cd0F1] = true;

        // TREE/USD: 0x8fCC2d2973e3740c40aF00d030725A429cd24b57
        _chainlink_feeds[0x8fCC2d2973e3740c40aF00d030725A429cd24b57] = true;

        // TRX/USD: 0xF4C5e535756D11994fCBB12Ba8adD0192D9b88be
        _chainlink_feeds[0xF4C5e535756D11994fCBB12Ba8adD0192D9b88be] = true;

        // TSM/USD: 0x685fC5acB74CE3d5DF03543c9813C73DFCe50de8
        _chainlink_feeds[0x685fC5acB74CE3d5DF03543c9813C73DFCe50de8] = true;

        // TUSD/USD: 0xa3334A9762090E827413A7495AfeCE76F41dFc06
        _chainlink_feeds[0xa3334A9762090E827413A7495AfeCE76F41dFc06] = true;

        // TWT/BNB: 0x7E728dFA6bCa9023d9aBeE759fDF56BEAb8aC7aD
        _chainlink_feeds[0x7E728dFA6bCa9023d9aBeE759fDF56BEAb8aC7aD] = true;

        // UNH/USD: 0xC18c5A32c84CbbAc7D0F06Dd370198DA711c73C9
        _chainlink_feeds[0xC18c5A32c84CbbAc7D0F06Dd370198DA711c73C9] = true;

        // UNI/BNB: 0x25298F020c3CA1392da76Eb7Ac844813b218ccf7
        _chainlink_feeds[0x25298F020c3CA1392da76Eb7Ac844813b218ccf7] = true;

        // UNI/USD: 0xb57f259E7C24e56a1dA00F66b55A5640d9f9E7e4
        _chainlink_feeds[0xb57f259E7C24e56a1dA00F66b55A5640d9f9E7e4] = true;

        // uniBTC/BTC Exchange Rate: 0x921Fa3C67286385b22dE244e51E5925D98B03130
        _chainlink_feeds[0x921Fa3C67286385b22dE244e51E5925D98B03130] = true;

        // USD1/USD: 0xaD8b4e59A7f25B68945fAf0f3a3EAF027832FFB0
        _chainlink_feeds[0xaD8b4e59A7f25B68945fAf0f3a3EAF027832FFB0] = true;

        // USDC/BNB: 0x45f86CA2A8BC9EBD757225B19a1A0D7051bE46Db
        _chainlink_feeds[0x45f86CA2A8BC9EBD757225B19a1A0D7051bE46Db] = true;

        // USDC/USD: 0x51597f405303C4377E36123cBc172b13269EA163
        _chainlink_feeds[0x51597f405303C4377E36123cBc172b13269EA163] = true;

        // USDE/USD: 0x10402B01cD2E6A9ed6DBe683CbC68f78Ff02f8FC
        _chainlink_feeds[0x10402B01cD2E6A9ed6DBe683CbC68f78Ff02f8FC] = true;

        // USDf/USD: 0xedE67e8dda821090e019Be754A7F61b4129FbF17
        _chainlink_feeds[0xedE67e8dda821090e019Be754A7F61b4129FbF17] = true;

        // USDT/BNB: 0xD5c40f5144848Bd4EF08a9605d860e727b991513
        _chainlink_feeds[0xD5c40f5144848Bd4EF08a9605d860e727b991513] = true;

        // USDT/USD: 0xB97Ad0E74fa7d920791E90258A6E2085088b4320
        _chainlink_feeds[0xB97Ad0E74fa7d920791E90258A6E2085088b4320] = true;

        // USR/USD: 0xE8ed18E29402CD223bC5B73D30e40CCdf7b72986
        _chainlink_feeds[0xE8ed18E29402CD223bC5B73D30e40CCdf7b72986] = true;

        // VAI/USD: 0x058316f8Bb13aCD442ee7A216C7b60CFB4Ea1B53
        _chainlink_feeds[0x058316f8Bb13aCD442ee7A216C7b60CFB4Ea1B53] = true;

        // VET/USD: 0x9f1fD2cEf7b226D555A747DA0411F93c5fe74e13
        _chainlink_feeds[0x9f1fD2cEf7b226D555A747DA0411F93c5fe74e13] = true;

        // VT/USD: 0xa3D5BB7e8ccc2Dc7492537cc2Ec4e4E7BBA32fa0
        _chainlink_feeds[0xa3D5BB7e8ccc2Dc7492537cc2Ec4e4E7BBA32fa0] = true;

        // weETH/eETH Exchange Rate: 0xF37Be32598E9851f785acA86c2162e7C1A8466dd
        _chainlink_feeds[0xF37Be32598E9851f785acA86c2162e7C1A8466dd] = true;

        // WIN/USD: 0x9e7377E194E41d63795907c92c3EB351a2eb0233
        _chainlink_feeds[0x9e7377E194E41d63795907c92c3EB351a2eb0233] = true;

        // WING/USD: 0xf7E7c0ffCB11dAC6eCA1434C67faB9aE000e10a7
        _chainlink_feeds[0xf7E7c0ffCB11dAC6eCA1434C67faB9aE000e10a7] = true;

        // WLFI/USD: 0xD3F669EF5C364C14d353F46b1D1a048A846e00f1
        _chainlink_feeds[0xD3F669EF5C364C14d353F46b1D1a048A846e00f1] = true;

        // WOO/USD: 0x02Bfe714e78E2Ad1bb1C2beE93eC8dc5423B66d4
        _chainlink_feeds[0x02Bfe714e78E2Ad1bb1C2beE93eC8dc5423B66d4] = true;

        // WSRUSD-RUSD Exchange Rate: 0x19995C3f82Ea476ae6c635BBbcb81c43030089eb
        _chainlink_feeds[0x19995C3f82Ea476ae6c635BBbcb81c43030089eb] = true;

        // wstETH/stETH Exchange Rate: 0x4c75d01cfa4D998770b399246400a6dc40FB9645
        _chainlink_feeds[0x4c75d01cfa4D998770b399246400a6dc40FB9645] = true;

        // WSTETH/USD: 0xd97aB9e5bD461eBcD55009791C410294f7B42Cdb
        _chainlink_feeds[0xd97aB9e5bD461eBcD55009791C410294f7B42Cdb] = true;

        // WSTUSR-STUSR Exchange Rate: 0xA40a0dC23D3A821fF5Ea9E23080B74DAC031158d
        _chainlink_feeds[0xA40a0dC23D3A821fF5Ea9E23080B74DAC031158d] = true;

        // WTI/USD: 0xb1BED6C1fC1adE2A975F54F24851c7F410e27718
        _chainlink_feeds[0xb1BED6C1fC1adE2A975F54F24851c7F410e27718] = true;

        // XAG/USD: 0x817326922c909b16944817c207562B25C4dF16aD
        _chainlink_feeds[0x817326922c909b16944817c207562B25C4dF16aD] = true;

        // XAU/USD: 0x86896fEB19D8A607c3b11f2aF50A0f239Bd71CD0
        _chainlink_feeds[0x86896fEB19D8A607c3b11f2aF50A0f239Bd71CD0] = true;

        // XLM/USD: 0x27Cc356A5891A3Fe6f84D0457dE4d108C6078888
        _chainlink_feeds[0x27Cc356A5891A3Fe6f84D0457dE4d108C6078888] = true;

        // XRP/BNB: 0x798A65D349B2B5E6645695912880b54dfFd79074
        _chainlink_feeds[0x798A65D349B2B5E6645695912880b54dfFd79074] = true;

        // XRP/USD: 0x93A67D414896A280bF8FFB3b389fE3686E014fda
        _chainlink_feeds[0x93A67D414896A280bF8FFB3b389fE3686E014fda] = true;

        // XTZ/BNB: 0x8264d6983B219be65C4D62f1c82B3A2999944cF2
        _chainlink_feeds[0x8264d6983B219be65C4D62f1c82B3A2999944cF2] = true;

        // XTZ/USD: 0x9A18137ADCF7b05f033ad26968Ed5a9cf0Bf8E6b
        _chainlink_feeds[0x9A18137ADCF7b05f033ad26968Ed5a9cf0Bf8E6b] = true;

        // XVS/BNB: 0xf369A13E7f2449E58DdE8302F008eE9131f8d859
        _chainlink_feeds[0xf369A13E7f2449E58DdE8302F008eE9131f8d859] = true;

        // XVS/USD: 0xBF63F430A79D4036A5900C19818aFf1fa710f206
        _chainlink_feeds[0xBF63F430A79D4036A5900C19818aFf1fa710f206] = true;

        // YBTC-BTC Exchange Rate: 0x0776362fF16beA8858e4F6bCA8d351941B75EbA1
        _chainlink_feeds[0x0776362fF16beA8858e4F6bCA8d351941B75EbA1] = true;

        // YETH-ETH Exchange Rate: 0x337B4889fed5557595c37a45c1BB9b057cC670AE
        _chainlink_feeds[0x337B4889fed5557595c37a45c1BB9b057cC670AE] = true;

        // YFI/BNB: 0xF841761481DF19831cCC851A54D8350aE6022583
        _chainlink_feeds[0xF841761481DF19831cCC851A54D8350aE6022583] = true;

        // YFI/USD: 0xD7eAa5Bf3013A96e3d515c055Dbd98DbdC8c620D
        _chainlink_feeds[0xD7eAa5Bf3013A96e3d515c055Dbd98DbdC8c620D] = true;

        // YFII/USD: 0xC94580FAaF145B2FD0ab5215031833c98D3B77E4
        _chainlink_feeds[0xC94580FAaF145B2FD0ab5215031833c98D3B77E4] = true;

        // YUSD-USD Exchange Rate: 0x83B8DF906c631dD7460Ac875Dc02A62db1dcD37A
        _chainlink_feeds[0x83B8DF906c631dD7460Ac875Dc02A62db1dcD37A] = true;

        // ZBU/USD: 0x4F3CF381c58Bf69b798167Cb537103d2c8ef1A71
        _chainlink_feeds[0x4F3CF381c58Bf69b798167Cb537103d2c8ef1A71] = true;

        // ZIL/USD: 0x3e3aA4FC329529C8Ab921c810850626021dbA7e6
        _chainlink_feeds[0x3e3aA4FC329529C8Ab921c810850626021dbA7e6] = true;

        // BSW/USD: 0x08E70777b982a58D23D05E3D7714f44837c06A21
        _chainlink_feeds[0x08E70777b982a58D23D05E3D7714f44837c06A21] = true;

        // SUSD1+-USD1 Exchange Rate: 0x08CA3ac4dE41F2791e8A247859d637a8977473D7
        _chainlink_feeds[0x08CA3ac4dE41F2791e8A247859d637a8977473D7] = true;
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
        // Allowed Amounts Stable: Tether has 18 decimals on BSC
        _allowed_amounts_stable[0.001 ether] = true;
        _allowed_amounts_stable[1 ether] = true;
        _allowed_amounts_stable[5 ether] = true;
        _allowed_amounts_stable[10 ether] = true;
        _allowed_amounts_stable[20 ether] = true;
        _allowed_amounts_stable[50 ether] = true;
        _allowed_amounts_stable[100 ether] = true;
        _allowed_amounts_stable[250 ether] = true;
        _allowed_amounts_stable[500 ether] = true;
        _allowed_amounts_stable[1000 ether] = true;
        _allowed_amounts_stable[2500 ether] = true;
        _allowed_amounts_stable[5000 ether] = true;
        // Allowed Coins to Play
        _allowed_coins_to_play[
            0x55d398326f99059fF775485246999027B3197955
        ] = true;
        _allowed_coins_to_play[
            0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        ] = true;

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
