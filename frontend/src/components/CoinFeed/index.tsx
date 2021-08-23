import { useContext, useEffect, useState } from "react";
import { MumbaiPriceFeeds } from "../../constants/MaticFeeds";
import { CoinsLeagueContext } from "../../hardhat/SymfoniContext";
import { CoinFeed } from "../../utils/types";

interface Props {
  address: string;
  gameAddress: string;
}

const getFeedFromAddress = (address?: string) => {
  if(address){
    return MumbaiPriceFeeds.find(a => a.address.toLowerCase() === address.toLowerCase())?.base
  }else{
    return 'No feed name';
  }

}

export const CoinFeedView = (props: Props) => {
  const coinsLeage = useContext(CoinsLeagueContext);
  const [coin, setCoin] = useState<CoinFeed>();
  const { address, gameAddress } = props;

  useEffect(() => {
    if (coinsLeage.instance && address && gameAddress) {
      coinsLeage.instance
        .attach(gameAddress)
        .coins(address)
        .then((c) => {
          console.log(c);
          setCoin({
            address: c.coin_feed,
            start_price: c.start_price,
            end_price: c.end_price,
            score: c.score,
          });
        });
    }
  }, [coinsLeage.instance]);

  return (
    <>
      <ul>
        <li>Address: {coin?.address}</li>
        <li>Feed: {getFeedFromAddress(coin?.address)}</li>
        <li>Start Price: {coin?.start_price?.toString()}</li>
        <li>End Price: {coin?.end_price?.toString()}</li>
        <li>Score: {coin?.score?.toString()}</li>
      </ul>
    </>
  );
};
