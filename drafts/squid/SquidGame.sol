//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract SquidGame is Ownable {

    uint256 currentRound;
    uint256 startTimestamp;
    uint256 endTimestamp;


    bool[6] challengeResult;
    mapping(address => bool) public Play;
    mapping(uint256 => Play) public PlayersPlay;
    mapping(uint256 => address[]) public PlayersRound;

    address[] public PlayersRound1;
    address[] public PlayersRound2;
    address[] public PlayersRound3;
    address[] public PlayersRound4;
    address[] public PlayersRound5;
    address[] public PlayersRound6;
    mapping(address => Play) public PlayersRoundMap;
    mapping(address => bool) public PlayersRound2Map;
    mapping(address => bool) public PlayersRound3Map;
    mapping(address => bool) public PlayersRound4Map;
    mapping(address => bool) public PlayersRound5Map;
    mapping(address => bool) public PlayersRound6Map;



    uint256 pot = 1 ether;

    constructor(uint256 _startTimestamp){
        currentRound = 0;
        startTimestamp = _startTimestamp;
    }

    function joinGame() external payable{
        require(msg.value == pot, "Need to sent exact amount of pot");
        require(PlayersRoundMap[msg.sender] == false, "Already joined");
        PlayersRound[currentRound].push(msg.sender);
        PlayersRoundMap[0][msg.sender] = true;
    }

    function goNextChallenge() external {
        if(currentRound == 1){
            require(PlayersPlay[0][msg.sender] == challengeResult[currentRound], "you not passed challenge");
            PlayersRound[currentRound].push(msg.sender);
        }
        if(currentRound == 2){
            require(PlayersPlay[1][msg.sender] == challengeResult[currentRound], "you not passed challenge");
             PlayersRound[currentRound].push(msg.sender);
        }
        if(currentRound == 3){
            require(PlayersPlay[2][msg.sender] == challengeResult[currentRound], "you not passed challenge");
             PlayersRound[currentRound].push(msg.sender);
        }
        if(currentRound == 4){
            require(PlayersPlay[3][msg.sender] == challengeResult[currentRound], "you not passed challenge");
             PlayersRound[currentRound].push(msg.sender);
        }
        if(currentRound == 5){
            require(PlayersPlay[4][msg.sender] == challengeResult[currentRound], "you not passed challenge");
             PlayersRound[currentRound].push(msg.sender);
        }
        if(currentRound == 6){
            require(PlayersPlay[5][msg.sender] == challengeResult[currentRound], "you not passed challenge");
             PlayersRound[currentRound].push(msg.sender);
        }
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

    function startChallengeOne() external {
        require(currentRound == 1, "You need to be on round 1");

    }

    function endChallengeOne() external {

        currentRound = 2;
    }

    function startChallengeTwo() external {
        require(currentRound == 2, "You need to be on round 1");

    }

    function endChallengeTwo() external {

        currentRound = 3;
    }

    function startChallengeThird() external {
        require(currentRound == 3, "You need to be on round 1");

    }

    function endChallengeThird() external {

        currentRound = 4;
    }

    function startChallengeFourth() external {
        require(currentRound == 4, "You need to be on round 1");

    }

    function endChallengeFourth() external {

        currentRound = 5;
    }

    function startChallengeFifth() external {
        require(currentRound == 5, "You need to be on round 1");

    }

    function endChallengeFifth() external {

        currentRound = 6;
    }

    function startChallengeSix() external {
        require(currentRound == 5, "You need to be on round 1");

    }

    function endChallengeSix() external {

        currentRound = 6;
    }




    function enterChallengeOne(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(block.timestamp < endTimestamp,   "challenge finished");
        require(PlayersRoundMap[0][msg.sender] == true,  "Player needs join game first");
        PlayersPlay[0][msg.sender] = play;
    }

    function enterChallengeTwo(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(block.timestamp < endTimestamp,   "challenge finished");
        require(PlayersRoundMap[1][msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[1][msg.sender] = play;
    }


    function enterChallengeThird(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRoundMap[2][msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[2][msg.sender] = play;
    }

    function enterChallengeFourth(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRoundMap[3][msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[3][msg.sender] = play;
    }

    function enterChallengeFive(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRoundMap[4][msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[4][msg.sender] = play;
    }

    function enterChallengeSix(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRoundMap[4][msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[5][msg.sender] = play;
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(coin_feed)
            .latestRoundData();
        return price;
    }


}