# Work In Progress

# CoinLeague

![image](assets/coins-league.png)

Game to be played on by multiple users to make them engaged daily on the platform.

Here you can create games and play with up to other 10 players, choose till 10 coins, up to 3 winners takes the pot.

Using ChainLink Price Feeds

## Structure

- frontend --> A unstyled proof of concept where users can play on Mumbai Polygon Testnet
- contracts --> Contracts used for the coinsleague game

## GAME FLOW

1. User create a game with several options as: amount, number of players, number of coins, abort date and duration of the game
2. When game is created, users need to join the game to fill all available spots, at this time users should choose their coins
3. When all spots are filled, we can start game, if not user can wait for the abort date to withdraw funds
4. When game duration is ended, user can end game
5. If user is a winner he can claim the pot depending on the place he was in

## V2

- Set start timestamps, add

## TODO

- [] Organize code

## REFERENCES

https://docs.matic.network/docs/develop/hardhat/

## Polygon Deployed Contracts V2

## Polygon Deployed Contracts

- Recent 
  Settings: 0x23C483CF1384cb872f6C443C763e479CaE0547eF
  Factory: 0x43fB5D9d4Dcd6D71d668dc6f12fFf97F35C0Bd7E

- Recent:
  Settings: 0xd3De46BEB6d0A8E80d42A317eE4943520C3edD69
  Factory: 0x8fFA73bB9404c6fa01A16e0F996787bD3F4CeF66

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

## Mumbai Deployed Contracts

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

## BSC deployed contracts

Factory: 0x5d5302993480eb4812f01b89b4823ac59a0cd136
Settings: 0x551c5d0D681Dd516c6b1BdA572A9891214D1d0C5

## Base Deployed Contracts

Factory: 0x34C21825ef6Bfbf69cb8748B4587f88342da7aFb
Settings: 0x9b912c3c568EDD07068E5dd5Ad39468809D81bb5


## Amoy Deployed Contracts

- Tether
0x9b912c3c568EDD07068E5dd5Ad39468809D81bb5

# NFT League

Mini game where users use their NFT to battle in a 1:1. User can choose a multiplier and predict if the NFT coin will go up or down.

Mumbai Deployed Contracts:

0x9565C656f26C55a18af32dab3bE8aaff1B0BbB72

# Squid League

Squid Game but applied to prediction markets. There is a total of 6 rounds, user in each round needs to enter challenge, and predict if coin goes up or down, if fail user is eliminated by the squid. In each round , there is a open vote to exit the game or not.

Users that went to final 6 round will split the prize with the alived players.

Mumbai Deployed Contracts:

0xaF8aa1952bbB2c4AbE14C027224B44d2f683f73B
