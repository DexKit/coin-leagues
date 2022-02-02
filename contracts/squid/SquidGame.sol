//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
* In progress
 */
contract SquidGame is Ownable {
     enum GameType {
        Winner,
        Loser
    }
    uint256 currentRound;
    uint256 startTimestamp;
    uint256 endTimestamp;
    enum  ChallengeState{
        Setup,
        Started,
        Finished
    }
    ChallengeState gameState;
    bool[6] challengeResult;

    struct Coin {
        address feed;
        int256 start_price;
        uint256 start_timestamp;
        uint256 duration;
        int256 end_price;
        int256 score;
        uint256 game_type;

    }
    mapping(uint256 => Coin) public CoinRound;

    Coin public coin;

    mapping(uint256 => mapping(address => bool)) public PlayersPlay;
    mapping(uint256 => address[]) public PlayersRound;
    mapping(uint256 => mapping(address => bool)) public PlayersRoundMap;
    uint256 public pot = 1 ether;
    uint256 lastChallengeTimestamp;
    constructor(uint256 _startTimestamp, uint _pot){
        currentRound = 0;
        startTimestamp = _startTimestamp;
        pot = _pot;
    }
    /**
    * Join Game at initial round
    */
    function joinGame(bool play) external payable{
        require(msg.value == pot, "Need to sent exact amount of pot");
        require(PlayersRoundMap[0][msg.sender] == false, "Already joined");
        PlayersRound[0].push(msg.sender);
        PlayersRoundMap[0][msg.sender] = true;
        PlayersPlay[0][msg.sender] = play;
    }

    /**
     *  Go to Next Challenge
     */
    function goNextChallenge(bool play) external {
        require(PlayersPlay[currentRound][msg.sender] == challengeResult[currentRound], "you not passed challenge");
        require(gameState == ChallengeState.Finished, "Challenge still not finished");
        PlayersRound[currentRound + 1].push(msg.sender);
        PlayersRoundMap[currentRound + 1][msg.sender] = true;
        PlayersPlay[currentRound + 1][msg.sender] = play;
      
    }

    /**
     *  Enter current round
     */
   // function enterCurrentRound(bool play) external {
      //  require(block.timestamp > startTimestamp, "Not started yet");
      // require(block.timestamp < endTimestamp,   "Challenge finished");
     //   require(lastChallengeTimestamp + 24*3600 < block.timestamp, "Challenge needs at least to pass 24 hours to go next round");
     //   require(PlayersRoundMap[currentRound + 1][msg.sender] == true, "You not passed on this round");
     //   PlayersPlay[currentRound][msg.sender] = play;
   // }
    // We setup first the challenge to start in few hours
    function setupChallenge() external {
            require(block.timestamp > lastChallengeTimestamp + 24*3600, "Challenge needs at least to pass 24 hours to go next round");
            uint256 gameType = _random(0) % 1;
            uint256 feed = _random(1) % 8;         
            CoinRound[currentRound] = Coin(getFeeds()[feed], 0, 0, 0, 0 ,0, gameType);
            CoinRound[currentRound].start_timestamp = block.timestamp + 3600;
            //we do rounds of one hour
            CoinRound[currentRound].duration = 3600;
    }
    // The challenge starts
    function startChallenge() external {
            require(block.timestamp >  CoinRound[currentRound].start_timestamp , "Challenge needs at least to pass 24 hours to start next round");
            CoinRound[currentRound].start_price = getPriceFeed(CoinRound[currentRound].feed);
            gameState = ChallengeState.Started;

    }

    function endChallenge() external {       
          require(block.timestamp > CoinRound[currentRound].start_timestamp + CoinRound[currentRound].duration, "Need at least one hour to finish"  );
          CoinRound[currentRound].end_price = getPriceFeed(CoinRound[currentRound].feed);
          CoinRound[currentRound].score = (((CoinRound[currentRound].end_price - CoinRound[currentRound].start_price)* 100000   ) / CoinRound[currentRound].end_price );
          if(CoinRound[currentRound].score > 0 && CoinRound[currentRound].game_type == 0){
              challengeResult[currentRound] = true;
          }else{
              challengeResult[currentRound] = false;
          }
          currentRound = currentRound +1;
          lastChallengeTimestamp = block.timestamp;
          gameState = ChallengeState.Finished;
    }


    /**
    * Total pot depends on eleminated players
     */
    function getTotalPot() external view returns(uint256){
        if(currentRound > 0){
            return (PlayersRound[0].length - PlayersRound[currentRound].length)*pot;
        }else{
            return 0;
        }
    }
    function getCurrentPlayers() external view returns(uint256){
        return PlayersRound[currentRound].length;
    }

    function getCurrentPlayersAtRound(uint256 round) external view returns(uint256){
        require(round < currentRound, "round can not be higher than current one");
        return PlayersRound[round].length;
    }

    

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(coin_feed)
            .latestRoundData();
        return price;
    }

     // We generate a pseudo random number, just for fun
    function _random(uint256 tokenId) private view returns (uint) {   
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, tokenId)));   
    }

     /**
     * returns feed associated with coin
     */
    function getFeeds()
        internal
        pure
        returns (address[7] memory)
    {
        return [
            // BTC
            0xc907E116054Ad103354f2D350FD2514433D57F6f,
            // ETH
            0xF9680D99D6C9589e2a93a78A04A279e509205945,
            // DOT
            0xacb51F1a83922632ca02B25a8164c10748001BdE,
            // LINK,
            0xd9FFdb71EbE7496cC440152d43986Aae0AB76665,
            // UNI
            0xdf0Fb4e4F928d2dCB76f438575fDD8682386e13C,
            //ADA
            0x882554df528115a743c4537828DA8D5B58e52544,
            // DOGE
            0xbaf9327b6564454F4a3364C33eFeEf032b4b4444
        ];
    }


}