import { CoinFeed } from "../../utils/types";

interface Props {
  coin: CoinFeed;
}

export const CoinFeedView = (props: Props) => {
  const { coin } = props;

  return (
    <>
      <ul>
        <li>Address: {coin?.address}</li>
        <li>Start Price: {coin?.start_price?.toString()}</li>
        <li>End Price: {coin?.end_price?.toString()}</li>
        <li>Score: {coin?.score?.toString()}</li>
      </ul>
    </>
  );
};
