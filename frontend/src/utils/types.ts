import { BigNumber } from "ethers";

export interface Player{
    score: BigNumber;
    address: string;
    coin_feeds?: string[];


}

export interface CoinFeed{
   address: string
   start_price: BigNumber
   end_price: BigNumber
   score: BigNumber
}