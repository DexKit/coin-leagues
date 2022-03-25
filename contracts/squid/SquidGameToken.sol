//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * In progress
 */
contract SquidGameToken is Ownable {
    using SafeERC20 for IERC20;
    enum GameType {
        Winner,
        Loser
    }

    uint256 currentRound;
    uint256 public startTimestamp;
    uint256 public endTimestamp;
    uint256 constant MAX_ROUNDS = 6;
    enum ChallengeState {
        Joining,
        Setup,
        Started,
        Finished,
        Quit
    }
    ChallengeState public gameState;
    bool[MAX_ROUNDS] public challengeResult;
    address houseAddress = address(0);
    address internal immutable NativeCoin =
        0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    event PlayerJoinedRound(
        uint256 round,
        address player,
        uint256 created_at,
        bool play
    );

    event PlayerJoined(address player, uint256 created_at);
    event ChallengeSetup(uint256 round, address feed, uint256 created_at);
    event ChallengeStarted(
        uint256 round,
        int256 start_price,
        uint256 created_at
    );
    event ChallengeFinished(
        uint256 round,
        int256 end_price,
        uint256 created_at,
        bool result
    );

    event VoteToQuit(uint256 round, address player, uint256 created_at);

    event GameQuitted(
        uint256 round,
        uint256 amount_voted,
        uint256 amount_total,
        uint256 created_at
    );

    event Withdrawed(uint256 amount, address player, uint256 created_at);

    event WithdrawedHouse(uint256 amount, uint256 created_at);
    struct Coin {
        address feed;
        int256 start_price;
        uint256 start_timestamp;
        uint256 duration;
        int256 end_price;
        int256 score;
    }

    mapping(uint256 => Coin) public CoinRound;

    bool _houseWithdrawed = false;

    mapping(uint256 => mapping(address => bool)) public PlayersPlay;
    address[] public PlayersJoined;
    mapping(uint256 => address[]) public PlayersRound;
    mapping(uint256 => address[]) public PlayersVote;
    mapping(uint256 => mapping(address => bool)) public PlayersVoteMap;
    mapping(uint256 => mapping(address => bool)) public PlayersRoundMap;
    mapping(address => bool) public PlayersJoinedMap;
    mapping(address => bool) public PlayerWithdraw;
    uint256 public pot = 1 ether;
    address public coin_to_play;
    uint256 public lastChallengeTimestamp;

    constructor(
        uint256 _startTimestamp,
        uint256 _pot,
        address _coin_to_play
    ) {
        currentRound = 0;
        require(_startTimestamp > block.timestamp, "future date required");
        startTimestamp = _startTimestamp;
        pot = _pot;
        gameState = ChallengeState.Joining;
        coin_to_play = _coin_to_play;
    }

    function joinGame() external payable {
        if (coin_to_play == NativeCoin) {
            require(msg.value == pot, "Need to sent exact amount of pot");
        } else {
            IERC20(coin_to_play).safeTransferFrom(
                msg.sender,
                address(this),
                pot
            );
        }

        require(PlayersJoinedMap[msg.sender] == false, "Already joined");
        PlayersJoinedMap[msg.sender] = true;
        PlayersJoined.push(msg.sender);
        emit PlayerJoined(msg.sender, block.timestamp);
    }

    /**
     *  Go to Next Challenge
     */
    function playChallenge(bool play) external {
        require(
            PlayersJoinedMap[msg.sender] == true,
            "you need join game to be able to go next challenges"
        );
        if (currentRound > 0) {
            require(
                PlayersRoundMap[currentRound - 1][msg.sender] == true,
                "you need to been on previous round"
            );
            require(
                PlayersPlay[currentRound - 1][msg.sender] ==
                    challengeResult[currentRound - 1],
                "you not passed challenge"
            );
        }
        require(
            gameState == ChallengeState.Setup,
            "Challenge needs to be setup phase"
        );
        require(currentRound < MAX_ROUNDS, "There is only 6 rounds");
        require(
            PlayersRoundMap[currentRound][msg.sender] == false,
            "You already played"
        );
        PlayersRound[currentRound].push(msg.sender);
        PlayersRoundMap[currentRound][msg.sender] = true;
        PlayersPlay[currentRound][msg.sender] = play;
        emit PlayerJoinedRound(currentRound, msg.sender, block.timestamp, play);
    }

    // We setup first the challenge to start in few hours
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
        require(currentRound < MAX_ROUNDS, "No more challenges");

        uint256 feed = _random(1) % 8;
        CoinRound[currentRound] = Coin(getFeeds()[feed], 0, 0, 0, 0, 0);
        CoinRound[currentRound].start_timestamp = block.timestamp + 3600;
        //we do rounds of one hour
        CoinRound[currentRound].duration = 3600;
        gameState = ChallengeState.Setup;
        emit ChallengeSetup(currentRound, getFeeds()[feed], block.timestamp);
    }

    // The challenge starts
    function startChallenge() external {
        require(
            block.timestamp > CoinRound[currentRound].start_timestamp,
            "Challenge not started"
        );
        require(gameState != ChallengeState.Started, "Already started");
        require(gameState != ChallengeState.Quit, "Game was finished");
        require(currentRound < MAX_ROUNDS, "No more challenges");

        CoinRound[currentRound].start_price = getPriceFeed(
            CoinRound[currentRound].feed
        );
        gameState = ChallengeState.Started;
        CoinRound[currentRound].start_timestamp = block.timestamp;
        emit ChallengeStarted(
            currentRound,
            CoinRound[currentRound].start_price,
            block.timestamp
        );
    }

    function finishChallenge() external {
        require(
            block.timestamp >
                CoinRound[currentRound].start_timestamp +
                    CoinRound[currentRound].duration,
            "Duration not elapsed yet"
        );
        require(gameState != ChallengeState.Finished, "Game already finished");
        require(currentRound < MAX_ROUNDS, "No more challenges");
        CoinRound[currentRound].end_price = getPriceFeed(
            CoinRound[currentRound].feed
        );
        CoinRound[currentRound].score = (((CoinRound[currentRound].end_price -
            CoinRound[currentRound].start_price) * 100000) /
            CoinRound[currentRound].end_price);

        if (CoinRound[currentRound].score > 0) {
            challengeResult[currentRound] = true;
        } else {
            challengeResult[currentRound] = false;
        }

        currentRound = currentRound + 1;
        lastChallengeTimestamp = block.timestamp;
        gameState = ChallengeState.Finished;
        emit ChallengeFinished(
            currentRound - 1,
            CoinRound[currentRound - 1].end_price,
            block.timestamp,
            challengeResult[currentRound - 1]
        );
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
        emit VoteToQuit(currentRound, msg.sender, block.timestamp);
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
            emit GameQuitted(
                currentRound,
                PlayersVote[currentRound].length,
                PlayersRound[currentRound].length,
                block.timestamp
            );
        }
    }

    /**
     * Total pot depends on joined players
     */
    function getTotalPot() public view returns (uint256) {
        if (currentRound > 0) {
            return (PlayersJoined.length) * pot;
        } else {
            return 0;
        }
    }

    function getCurrentPlayers() external view returns (uint256) {
        return PlayersRound[currentRound].length;
    }

    function getJoinedPlayers() external view returns (uint256) {
        return PlayersJoined.length;
    }

    function getCurrentRound() external view returns (uint256) {
        return currentRound;
    }

    function getPlayerCurrentChallengeResultAtRound(
        address player,
        uint256 round
    ) external view returns (bool) {
        require(round <= currentRound, "round is higher than current round");
        return PlayersPlay[round][player] == challengeResult[round];
    }

    function withdraw() external {
        require(
            (currentRound == MAX_ROUNDS &&
                PlayersPlay[MAX_ROUNDS - 1][msg.sender] ==
                challengeResult[MAX_ROUNDS - 1]) ||
                gameState == ChallengeState.Quit,
            "Game not finished yet"
        );
        require(PlayerWithdraw[msg.sender] == false, "Already withdrawed");
        PlayerWithdraw[msg.sender] = true;

        uint256 totalPotMinusHouse = getTotalPot() - (getTotalPot() * 10) / 100;
        uint256 currentPlayers;
        if (currentRound == MAX_ROUNDS) {
            currentPlayers = PlayersRound[MAX_ROUNDS - 1].length;
        } else {
            // If we used the Challenge Quit  early
            currentPlayers = PlayersRound[currentRound].length;
        }
        uint256 amountToSend = totalPotMinusHouse / currentPlayers;
        if (coin_to_play == NativeCoin) {
            (bool sent, ) = msg.sender.call{value: amountToSend}("");
            require(sent, "Failed to send Ether");
        } else {
            IERC20(coin_to_play).safeTransfer(msg.sender, amountToSend);
        }

        emit Withdrawed(amountToSend, msg.sender, block.timestamp);
    }

    function withdrawHouse() external {
        require(
            currentRound == MAX_ROUNDS || gameState == ChallengeState.Quit,
            "Game not finished yet"
        );
        require(_houseWithdrawed == false, "House already withdrawed");
        _houseWithdrawed = true;
        uint256 totalPotHouse = (getTotalPot() * 10) / 100;
        // If all the players were eliminated, house takes all;
        if (PlayersRound[currentRound].length == 0) {
            totalPotHouse = getTotalPot();
        }
        if (coin_to_play == NativeCoin) {
            (bool sent, ) = houseAddress.call{value: totalPotHouse}("");
            require(sent, "Failed to send Ether");
        } else {
            IERC20(coin_to_play).safeTransfer(msg.sender, totalPotHouse);
        }
        emit WithdrawedHouse(totalPotHouse, block.timestamp);
    }

    function getCurrentPlayersAtRound(uint256 round)
        external
        view
        returns (uint256)
    {
        require(
            round <= currentRound,
            "round can not be higher than current one"
        );
        return PlayersRound[round].length;
    }

    function getCurrentRoundPriceFeed() public view returns (int256) {
        (, int256 price, , , ) = AggregatorV3Interface(
            CoinRound[currentRound].feed
        ).latestRoundData();
        return price;
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
            // ADA
            0x882554df528115a743c4537828DA8D5B58e52544,
            // DOGE
            0xbaf9327b6564454F4a3364C33eFeEf032b4b4444
        ];
    }
}
