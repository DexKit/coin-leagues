
import { Player } from "../../utils/types"
import { CoinFeedView } from "../CoinFeed"
interface Props{
    player: Player, 
    address: string,
}

export const PlayerView = (props: Props) => {
    const {player, address} = props;

    return <div className='Game-View-Detail'>
                <h3>Player Details</h3>
                <ul>
                    <li>Address: {String(player?.address)}</li>
                    <li>Score: {player.score.toString()}</li>
                </ul>
                <div className='Player-Coin-Feeds'>
                  {player?.coin_feeds?.map((c)=> <CoinFeedView address={c} gameAddress={address}/> )}
                </div>
            </div>

}