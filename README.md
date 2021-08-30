# CoinsLeague

![image](assets/coins-league.png)


Game to be played on by multiple users  to make them engaged daily on the platform.

Here you can create games and play with up to other 10 players, choose till 10 coins, up to 3 winners takes the pot.

Using ChainLink Price Feeds

# Structure

- frontend --> A unstyled proof of concept where users can play on Mumbai Polygon Testnet
- contracts --> Contracts used for the coinsleague game

# GAME FLOW

1. User create a game with several options as: amount, number of players, number of coins, abort date and duration of the game
2. When game is created, users need to join the game to fill all available spots, at this time users should choose their coins
3. When all spots are filled, we can start game, if not user can wait for the abort date to withdraw funds
4. When game duration is ended, user can end game
5. If user is a winner he can claim the pot depending on the place he was in

# REFERENCES

https://docs.matic.network/docs/develop/hardhat/

# Mumbai Deployed Contracts

Recent: 0xa1B3a09D5f83a52085fd37becb229038bCeacFf3

Later contracts:

0x9b912c3c568EDD07068E5dd5Ad39468809D81bb5