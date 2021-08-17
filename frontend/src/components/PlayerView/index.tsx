import { BigNumber } from "ethers"
import { Player } from "../../utils/types"
import { CoinFeedView } from "../CoinFeed"
interface Props{
    player: Player
}

export const PlayerView = (props: Props) => {
    const {player} = props;

    return <div className='Game-View-Detail'>
                <h3>Player Details</h3>
                <ul>
                    <li>Address: {String(player?.address)}</li>
                    <li>Score: {player.score.toString()}</li>
                </ul>
                <div className='Player-Coin-Feeds'>
                  {player?.coin_feeds?.map((c)=> <CoinFeedView coin={c}/> )}
                </div>
            </div>

}