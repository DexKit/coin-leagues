# Work In Progress

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

# Polygon Deployed Contracts

- Recent:
Settings: 0x72512faB2712B3Cb69c415c47dA7ACE126F78674
Factory: 0x4Bd57b86736833F73218BcF33793868dbe21E30d


- Recent:
Settings: 0x190CC6Aecf8eC1D5D582AFae5ad285638394582f
Factory: 0x6D9993E719742a9Cf4eC1D5F5e7d49Bd48C1D9B1

- Recent:
Settings: 0xB52bA564C50EF0fA82cA37d44615FDB80015F8e3
Factory: 0xa033640f5536331b3d3F395d81901C744E343767

Later Contracts:
Settings: 0x5776797cAde9158205729286d9f364C860CC5EDE
Factory: 0xb2198f7A487020DCd23D035aaB1E216e49836F2D

Settings: 0x9b912c3c568EDD07068E5dd5Ad39468809D81bb5
Factory: 0x34C21825ef6Bfbf69cb8748B4587f88342da7aFb

# Mumbai Deployed Contracts

- Recent:
0xE8b44C6f791ddD0681234fB09907E219784aeA9E


- Later contracts:
0x7560E5Ee0734B59E7D1D8508c39AF744256e8509
0x1539ffBa6D1c63255dD9F61627c8B4a855E82F2a
0x8ab8c5616dF884e4a966685168559C77b832ba7C
0xd7b9843ea2681EDFf668333a1d908fa1e99953C9
0xF71a5F8DA88c8b4a322901D776D4A310F85200Bb
0xa1B3a09D5f83a52085fd37becb229038bCeacFf3
0x9b912c3c568EDD07068E5dd5Ad39468809D81bb5