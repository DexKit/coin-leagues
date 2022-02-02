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
    enum ChallengeState {
        Setup,
        Started,
        Finished,
        Quit
    }
    ChallengeState gameState;
    bool[6] challengeResult;
    address houseAddress = address(0);

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
    mapping(uint256 => address[]) public PlayersVote;
    mapping(uint256 => mapping(address => bool)) public PlayersVoteMap;
    mapping(uint256 => mapping(address => bool)) public PlayersRoundMap;
    uint256 public pot = 1 ether;
    uint256 lastChallengeTimestamp;

    constructor(uint256 _startTimestamp, uint256 _pot) {
        currentRound = 0;
        startTimestamp = _startTimestamp;
        pot = _pot;
    }

    /**
     * Join Game at initial round
     */
    function joinGame(bool play) external payable {
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
        require(
            PlayersRoundMap[0][msg.sender] == true,
            "you need join game to be able to go next challenges"
        );
        require(
            PlayersRoundMap[currentRound - 1][msg.sender] == true,
            "you need to been on previous round"
        );
        require(
            PlayersPlay[currentRound - 1][msg.sender] ==
                challengeResult[currentRound - 1],
            "you not passed challenge"
        );
        require(
            gameState == ChallengeState.Finished,
            "Challenge still not finished"
        );
        require(currentRound + 1 < 7, "There is only 6 rounds");
        PlayersRound[currentRound].push(msg.sender);
        PlayersRoundMap[currentRound][msg.sender] = true;
        PlayersPlay[currentRound][msg.sender] = play;
    }

    // We setup first the challenge to start in few a hour
    function setupChallenge() external {
        require(block.timestamp > startTimestamp, "Tournament not started");
        require(
            block.timestamp > lastChallengeTimestamp + 24 * 3600,
            "Challenge needs at least to pass 24 hours to go next round"
        );
        require(gameState != ChallengeState.Started, "challenge started");
        require(
            gameState != ChallengeState.Setup,
            "challenge was already setup"
        );
        uint256 gameType = _random(0) % 1;
        uint256 feed = _random(1) % 8;
        CoinRound[currentRound] = Coin(
            getFeeds()[feed],
            0,
            0,
            0,
            0,
            0,
            gameType
        );
        CoinRound[currentRound].start_timestamp = block.timestamp + 3600;
        //we do rounds of one hour
        CoinRound[currentRound].duration = 3600;
        gameState = ChallengeState.Setup;
    }

    // The challenge starts
    function startChallenge() external {
        require(
            block.timestamp > CoinRound[currentRound].start_timestamp,
            "Challenge not started"
        );
        require(gameState != ChallengeState.Started, "Already started");
        require(gameState != ChallengeState.Quit, "Game was finished");
        CoinRound[currentRound].start_price = getPriceFeed(
            CoinRound[currentRound].feed
        );
        gameState = ChallengeState.Started;
    }

    function finishChallenge() external {
        require(
            block.timestamp >
                CoinRound[currentRound].start_timestamp +
                    CoinRound[currentRound].duration,
            "Duration not elapsed yet"
        );
        require(gameState != ChallengeState.Finished, "Game already finished");
        CoinRound[currentRound].end_price = getPriceFeed(
            CoinRound[currentRound].feed
        );
        CoinRound[currentRound].score = (((CoinRound[currentRound].end_price -
            CoinRound[currentRound].start_price) * 100000) /
            CoinRound[currentRound].end_price);
        // If it is bull score needs to be positive
        if (CoinRound[currentRound].game_type == 0) {
            if (CoinRound[currentRound].score > 0) {
                challengeResult[currentRound] = true;
            } else {
                challengeResult[currentRound] = false;
            }
        }
        // If it is bear score needs to be negative
        if (CoinRound[currentRound].game_type == 1) {
            if (CoinRound[currentRound].score > 0) {
                challengeResult[currentRound] = false;
            } else {
                challengeResult[currentRound] = true;
            }
        }
        currentRound = currentRound + 1;
        lastChallengeTimestamp = block.timestamp;
        gameState = ChallengeState.Finished;
    }

    function voteEndGame() external {
        require(
            PlayersVoteMap[currentRound][msg.sender] == false,
            "You already voted on this round"
        );
        require(
            gameState == ChallengeState.Finished,
            "Challenge needs to be finished to vote"
        );
        PlayersVote[currentRound].push(msg.sender);
        PlayersVoteMap[currentRound][msg.sender] = true;
    }

    // If majority of players voted to quit the game, game just quit
    function computeEndGame() external {
        require(
            gameState == ChallengeState.Setup,
            "Only on Setup State we can end the challenge"
        );
        if (
            2 * PlayersVote[currentRound].length >
            PlayersRound[currentRound].length
        ) {
            gameState = ChallengeState.Quit;
        }
    }

    /**
     * Total pot depends on joined players
     */
    function getTotalPot() public view returns (uint256) {
        if (currentRound > 0) {
            return (PlayersRound[0].length) * pot;
        } else {
            return 0;
        }
    }

    function getCurrentPlayers() external view returns (uint256) {
        return PlayersRound[currentRound].length;
    }

    function withdraw() external {
        require(
            currentRound == 6 || gameState == ChallengeState.Quit,
            "Game not finished yet"
        );
        uint256 totalPotMinusHouse = getTotalPot() - (getTotalPot() * 10) / 100;
        uint256 currentPlayers = PlayersRound[currentRound].length;

        (bool sent, ) = msg.sender.call{
            value: totalPotMinusHouse / currentPlayers
        }("");
        require(sent, "Failed to send Ether");
    }

    function withdrawHouse() external {
        require(
            currentRound == 6 || gameState == ChallengeState.Quit,
            "Game not finished yet"
        );
        uint256 totalPotHouse = (getTotalPot() * 10) / 100;

        (bool sent, ) = houseAddress.call{value: totalPotHouse}("");
        require(sent, "Failed to send Ether");
    }

    function getCurrentPlayersAtRound(uint256 round)
        external
        view
        returns (uint256)
    {
        require(
            round < currentRound,
            "round can not be higher than current one"
        );
        return PlayersRound[round].length;
    }

    function getPriceFeed(address coin_feed) public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(coin_feed)
            .latestRoundData();
        return price;
    }

    // We generate a pseudo random number, just for fun
    function _random(uint256 tokenId) private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.difficulty, block.timestamp, tokenId)
                )
            );
    }

    /**
     * returns feed associated with coin
     */
    function getFeeds() internal pure returns (address[7] memory) {
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
