//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CoinLeagueChampions is ERC721, VRFConsumerBase, Ownable {
    using Counters for Counters.Counter;
    using SafeERC20 for IERC20;
    Counters.Counter private _tokenIdCounter;
    address constant internal TEAM_WALLET = 0x69be1977431935eEfCEb3cb23A682Dd1b601A1D4;
    uint256 constant PRE_MINE_MAX_SUPPLY = 1000;
    uint256 constant MAX_SUPPLY_1 = 3300;
    uint256 constant MAX_SUPPLY_2 = 3300;
    uint256 constant MAX_SUPPLY_3 = 3400;
    uint256 constant MAX_SUPPLY = 11000;
    uint256 constant PRICE_FIRST = 115 ether;
    uint256 constant PRICE_SECOND =  115 ether;
    uint256 constant PRICE_THIRD = 115 ether;
    uint256 constant HOLDING_KIT = 50 * 10 ** 18;// 50 KIT
    uint256 constant HOLDING_BITT = 200 * 10 ** 18;// 200 BITT
 
    uint256 constant SALE_EARLY_TIMESTAMP_FIRST = 1637211600;
    uint256 constant SALE_TIMESTAMP_FIRST = 1637254800;

    uint256 constant SALE_EARLY_TIMESTAMP_SECOND = 1638421200;
    uint256 constant SALE_TIMESTAMP_SECOND = 1638464400;
    
    uint256 constant SALE_EARLY_TIMESTAMP_THIRD = 1639630800;
    uint256 constant SALE_TIMESTAMP_THIRD = 1639674000;
    
    
     // Properties used for games
    mapping(uint256 => uint256) public attack;
    mapping(uint256 => uint256) public defense;
    mapping(uint256 => uint256) public run;
    bytes32 internal keyHash;
    uint256 internal fee;

    uint256 public randomResult;
    IERC20 internal immutable DEXKIT = IERC20(0x4D0Def42Cf57D6f27CD4983042a55dce1C9F853c); 
    IERC20 internal immutable BITTOKEN = IERC20(0xfd0cbdDec28a93bB86B9db4A62258F5EF25fEfdE);
    // Mapping of rarity with token ID
    mapping(uint256 => uint256) internal rarity;
    mapping(bytes32 => address) public requestToSender;
    mapping(bytes32 => uint256) public requestToTokenId;
                                    //%1, 5 %, 7.5%, 9%, 12.5%, 15%                               
    uint256 [] accumulated_rarity = [0, 25, 75, 150, 240, 365, 515, 715, 1000];
    // VRF Data       
    // Item	Value
    // LINK Token	0xb0897686c545045aFc77CF20eC7A532E3120E0F1
    // VRF Coordinator	0x3d2341ADb2D31f1c5530cDC622016af293177AE0
    // Key Hash	0xf86195cf7690c55907b2b611ebb7343a6f649bff128701cc542f0569e2c549da
    // Fee	0.0001 LINK

    constructor()
    ERC721("CoinLeagueChampions", "Champions")
    VRFConsumerBase(
           0x3d2341ADb2D31f1c5530cDC622016af293177AE0,
           0xb0897686c545045aFc77CF20eC7A532E3120E0F1
        ) 
     {
        keyHash = 0xf86195cf7690c55907b2b611ebb7343a6f649bff128701cc542f0569e2c549da;
        fee = 0.0001 * 10**18; // 0.0001 LINK
    }
    // Owner can mint at any time
    function preMine() public onlyOwner returns (bytes32 requestId){
        require(_tokenIdCounter.current()  < PRE_MINE_MAX_SUPPLY, "Pre mine supply reached" );
        requestId = safeMint();
    }

    // Owner can mint to other users at any time
    function preMineTo(address to) public onlyOwner returns (bytes32 requestId){
        require(_tokenIdCounter.current() < PRE_MINE_MAX_SUPPLY, "Pre mine supply reached" );
        requestId = safeMintTo(to);
    }

    function mintFirstRound() public payable returns (bytes32 requestId){
        if(canSaleEarly()){
            require(block.timestamp >= SALE_EARLY_TIMESTAMP_FIRST );
        }else{
            require(block.timestamp >= SALE_TIMESTAMP_FIRST );
        }
        require(_tokenIdCounter.current()  >= PRE_MINE_MAX_SUPPLY, "Need to Premine First" );
        require(_tokenIdCounter.current()  < MAX_SUPPLY_1 + PRE_MINE_MAX_SUPPLY, "First Round Max Supply reached" );
        require(msg.value == PRICE_FIRST, "Sent exact price");
        requestId = safeMint();
        
    }

    function mintSecondRound() public payable returns (bytes32 requestId){
        if(canSaleEarly()){
            require(block.timestamp >= SALE_EARLY_TIMESTAMP_SECOND );
        }else{
            require(block.timestamp >= SALE_TIMESTAMP_SECOND );
        }
        require(_tokenIdCounter.current()  >= MAX_SUPPLY_1 + PRE_MINE_MAX_SUPPLY, "Still tokens on first round" );
        require(_tokenIdCounter.current()  < MAX_SUPPLY_1 + PRE_MINE_MAX_SUPPLY + MAX_SUPPLY_2, "Second Round Max Supply reached" );
        require(msg.value == PRICE_SECOND, "Sent exact price");
        requestId = safeMint();     
    }

    function mintThirdRound() public payable returns (bytes32 requestId){
        if(canSaleEarly()){
            require(block.timestamp >= SALE_EARLY_TIMESTAMP_THIRD );
        }else{
            require(block.timestamp >= SALE_TIMESTAMP_THIRD );
        }
        require(_tokenIdCounter.current() >= MAX_SUPPLY_1 + MAX_SUPPLY_2 + PRE_MINE_MAX_SUPPLY, "Still tokens on second round" );
        require(msg.value == PRICE_THIRD, "Sent exact price");
        requestId = safeMint();     
    }


    

    function safeMint() internal returns (bytes32 requestId)  {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with Link"
        );
        require(_tokenIdCounter.current() < MAX_SUPPLY, "Max Supply reached" );
        requestId = requestRandomness(keyHash, fee);
        requestToSender[requestId] = msg.sender;
        requestToTokenId[requestId] = _tokenIdCounter.current();
        _tokenIdCounter.increment();       
    }

    function safeMintTo(address to) internal returns (bytes32 requestId)  {
        require(
            LINK.balanceOf(address(this)) >= fee,
            "Not enough LINK - fill contract with Link"
        );
        require(_tokenIdCounter.current() < MAX_SUPPLY, "Max Supply reached" );
        requestId = requestRandomness(keyHash, fee);
        requestToSender[requestId] = to;
        requestToTokenId[requestId] = _tokenIdCounter.current();
        _tokenIdCounter.increment();       
    }

    function canSaleEarly() public returns(bool){
        return DEXKIT.balanceOf(msg.sender) >= HOLDING_KIT || BITTOKEN.balanceOf(msg.sender) >= HOLDING_BITT;
    }

    // Tokens are generated when id exists based on the defined rarity
    function _baseURI() internal pure override returns (string memory) {
        return "https://coinleaguechampions.dexkit.com/api/";
    }

    function contractURI() public view returns (string memory) { 
        return "https://coinleaguechampions.dexkit.com/info";
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
        internal
        override
    {
        uint256 id = requestToTokenId[requestId];
        uint256 randomRarity = (randomNumber % 1000);
        uint256 index = 0;
        for(uint256 i = 0; i < 8; i++){
            if(randomRarity >= accumulated_rarity[i] && randomRarity < accumulated_rarity[i + 1]){
                index = i;
                break;
            }
        }
        rarity[id] = index;
        attack[id] = uint256(keccak256(abi.encode(randomNumber, 1))) % 1000;
        defense[id] = uint256(keccak256(abi.encode(randomNumber, 2))) % 1000;
        run[id] = uint256(keccak256(abi.encode(randomNumber, 3))) % 1000;
        _safeMint(requestToSender[requestId], requestToTokenId[requestId]);
    }

    function getRarityOf(uint256 tokenId) public view returns(uint256){
        return rarity[tokenId];
    } 

    function withdrawLink() external onlyOwner{
        LINK.transfer(owner(), LINK.balanceOf(address(this)));
    }

    function withdrawETH() external payable onlyOwner{
       (bool sent, ) = TEAM_WALLET.call{
            value: address(this).balance
        }("");
        require(sent, "Failed to send Ether");
    }


}