import { BigNumber } from "ethers";

export interface Player{
    score: BigNumber;
    address: string;
    coin_feeds?: CoinFeed[];


}

export interface CoinFeed{
    address: string
   start_price: BigNumber
   end_price: BigNumber
   score: BigNumber
}