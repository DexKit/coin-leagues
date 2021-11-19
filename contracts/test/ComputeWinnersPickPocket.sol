//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "hardhat/console.sol";

/**
 * Contract used to test compute scores winners on the pick pocket game
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
        int[] memory scoreArr = new int[](10);
        uint256[] memory score_index = new uint256[](10);

        if (game.game_type == GameType.Winner) {
            for (uint256 index = 0; index < scoreArr.length; index++) {
                scoreArr[index] = -10000000;
            }     
        } else {
            for (uint256 index = 0; index < scoreArr.length; index++) {
                scoreArr[index] = 10000000;
            }
        }
        for (uint256 index = 0; index < score_index.length; index++) {
            score_index[index] = index;
        }
     
        for (uint256 index = 0; index < players.length; index++) {
            int256 score = players[index].score;
            if (game.game_type == GameType.Winner) {
                for (uint256 ind = 0; ind < score_index.length; ind++) {
                        if(score > scoreArr[ind]){
                            score_index[ind] = index;
                            scoreArr[ind] = score;
                            // We reorder here the score if needed
                            for (uint256 i = ind; i < score_index.length - 1; i++) {
                                    if(scoreArr[i] > scoreArr[i +1]){
                                        scoreArr[i+1] = scoreArr[i]; 
                                        score_index[i+1] =  score_index[i];     
                                }          
                            }
                        }
                }
            } else {
              for (uint256 ind = 0; ind < score_index.length; ind++) {
                        if(score < scoreArr[ind]){
                            score_index[ind] = index;
                            scoreArr[ind] = score;
                            // We reorder here the score if needed
                            for (uint256 i = ind; i < score_index.length - 1; i++) {
                                    if(scoreArr[i] < scoreArr[i +1]){
                                        scoreArr[i+1] = scoreArr[i]; 
                                        score_index[i+1] =  score_index[i];     
                                }          
                            }
                        }
                }
            }
        }

         for (uint8 index = 0; index < score_index.length; index++) {
             winners[players[score_index[index]].player_address] = Winner({
                place: index,
                winner_address: players[score_index[index]].player_address,
                score: players[score_index[index]].score,
                claimed: false
            });
        }
    }
}
