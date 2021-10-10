//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "hardhat/console.sol";

/**
 * Contract used to test compute scores winners
 * */
contract ComputeWinners {
    // Struct
    struct Player {
        address[] coin_feeds;
        address player_address;
        address captain_coin;
        uint256 champion_id;
        int256 score;
    }

    mapping(address => Winner) public winners;

    Player[] public players;

    enum GameType {
        Winner,
        Loser
    }

    Game public game;

    // Game could be of type loser or winner
    struct Game {
        GameType game_type;
    }

    struct Winner {
        // Struct
        uint8 place;
        address winner_address;
        int256 score;
        bool claimed;
    }

    function setGame(GameType game_type) public {
        game.game_type = game_type;
    }

    function pushPlayers(
        address[] memory coin_feeds,
        address captain_coin,
        uint256 champion_id,
        int256 score
    ) public {
        players.push(
            Player(coin_feeds, msg.sender, captain_coin, champion_id, score)
        );
    }

    /**
     * compute winners
     */
    function computeWinners() public {
        int256 score1;
        int256 score2;
        int256 score3;
        if (game.game_type == GameType.Winner) {
            score1 = -10000000;
            score2 = -10000000;
            score3 = -10000000;
        } else {
            score1 = 10000000;
            score2 = 10000000;
            score3 = 10000000;
        }
        // in case of draw wins first 3 players
        uint256 score1_index = 0;
        uint256 score2_index = 1;
        uint256 score3_index = 2;
        for (uint256 index = 0; index < players.length; index++) {
            int256 score = players[index].score;
            if (game.game_type == GameType.Winner) {
               if (score > score1) {
                    // We need to do this to sort properly always the winners
                    if (score1 > score2) {
                         if (score2 > score3) {
                            score3_index = score2_index;
                            score3 = score2;
                        }
                        score2_index = score1_index;
                        score2 = score1;
                    }

                    score1_index = index;
                    score1 = score;
                } else if (score > score2) {
                    if (score2 > score3) {
                        score3_index = score2_index;
                        score3 = score2;
                    }
                    score2_index = index;
                    score2 = score;
                } else if (score > score3) {
                    score3 = score;
                    score3_index = index;
                }
            } else {
                if (score < score1) {
                    if (score1 < score2) {
                        if(score2 < score3){
                            score3_index = score2_index;
                            score3 = score2; 
                        }
                        score2_index = score1_index;
                        score2 = score1;
                    }
                    score1_index = index;
                    score1 = score;
                } else if (score < score2) {
                    if (score2 < score3) {
                        score3_index = score2_index;
                        score3 = score2;
                    }
                    score2_index = index;
                    score2 = score;
                } else if (score < score3) {
                    score3 = score;
                    score3_index = index;
                }
            }
        }
 
        if (players.length > 3) {
            winners[players[score1_index].player_address] = Winner({
                place: 0,
                winner_address: players[score1_index].player_address,
                score: players[score1_index].score,
                claimed: false
            });
            winners[players[score2_index].player_address] = Winner({
                place: 1,
                winner_address: players[score2_index].player_address,
                score: players[score2_index].score,
                claimed: false
            });
            winners[players[score3_index].player_address] = Winner({
                place: 2,
                winner_address: players[score3_index].player_address,
                score: players[score3_index].score,
                claimed: false
            });
        } else {
            winners[players[score1_index].player_address] = Winner({
                place: 0,
                winner_address: players[score1_index].player_address,
                score: score1,
                claimed: false
            });
        }
    }
}
