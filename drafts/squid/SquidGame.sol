//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";



contract SquidGame is Ownable {

    uint256 currentRound;
    bool [6] challengeResult;
    mapping(address => bool) public Play;
    mapping(uint256 => Play) public PlayersPlay;

    address[] public PlayersRound1;
    address[] public PlayersRound2;
    address[] public PlayersRound3;
    address[] public PlayersRound4;
    address[] public PlayersRound5;
    address[] public PlayersRound6;
    uint256 pot = 1 ether;

    constructor(){
        currentRound = 0;
    }

    function joinGame() external payable{
        require(msg.value == pot, "Need to sent exact amount of pot");
        PlayersRound1.push(msg.sender);
    }

    function goNextChallenge() external {
        

    }

    function challengeOne(bool play) external {
        PlayersPlay[0][msg.sender] = play;
    }

}