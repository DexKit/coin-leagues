//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";



contract SquidGame is Ownable {

    uint256 currentRound;
    uint256 startTimestamp;
    uint256 endTimestamp;


    bool[6] challengeResult;
    mapping(address => bool) public Play;
    mapping(uint256 => Play) public PlayersPlay;

    address[] public PlayersRound1;
    address[] public PlayersRound2;
    address[] public PlayersRound3;
    address[] public PlayersRound4;
    address[] public PlayersRound5;
    address[] public PlayersRound6;
    mapping(address => bool) public PlayersRound1Map;
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
        require(PlayersRound1Map[msg.sender] == false, "Already joined");
        PlayersRound1.push(msg.sender);
        PlayersRound1Map[msg.sender] = true;
    }

    function goNextChallenge() external {
        if(currentRound == 1){
            require(PlayersPlay[0][msg.sender] == challengeResult[currentRound], "you not passed challenge");

        }
        if(currentRound == 2){
            require(PlayersPlay[1][msg.sender] == challengeResult[currentRound], "you not passed challenge");

        }
        if(currentRound == 3){
            require(PlayersPlay[2][msg.sender] == challengeResult[currentRound], "you not passed challenge");

        }
        if(currentRound == 4){
            require(PlayersPlay[3][msg.sender] == challengeResult[currentRound], "you not passed challenge");

        }
        if(currentRound == 5){
            require(PlayersPlay[4][msg.sender] == challengeResult[currentRound], "you not passed challenge");

        }
        if(currentRound == 6){
            require(PlayersPlay[5][msg.sender] == challengeResult[currentRound], "you not passed challenge");

        }

        

    }

    function challengeOne(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(block.timestamp < endTimestamp,   "challenge finished");
        require(PlayersRound1Map[msg.sender] == true,  "Player needs join game first");
        PlayersPlay[0][msg.sender] = play;
    }

    function challengeTwo(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(block.timestamp < endTimestamp,   "challenge finished");
        require(PlayersRound2Map[msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[1][msg.sender] = play;
    }


    function challengeThird(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRound3Map[msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[2][msg.sender] = play;
    }

    function challengeFourth(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRound4Map[msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[3][msg.sender] = play;
    }

    function challengeFive(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRound5Map[msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[4][msg.sender] = play;
    }

    function challengeSix(bool play) external {
        require(block.timestamp > startTimestamp, "not started yet");
        require(PlayersRound6Map[msg.sender] == true,  "Player needs pass round first");
        PlayersPlay[5][msg.sender] = play;
    }


}