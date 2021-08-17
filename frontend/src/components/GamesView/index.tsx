import { BigNumber, ethers } from "ethers";
import { useContext, useEffect, useState } from "react";
import { CoinsLeagueContext } from "../../hardhat/SymfoniContext";
import { Player } from "../../utils/types";
import { AbortGame } from "../Abort/Abort";
import { ClaimGame } from "../Claim/Claim";
import { EndGame } from "../EndGame/EndGame";
import { JoinGame } from "../JoinGame";
import { PlayerView } from "../PlayerView";
import { StartGame } from "../StartGame/StartGame";

import './style.css';
interface Props{
   address: string;
}

export const GameView = (props: Props) => {
    const {address} = props
    const [game, setGame] = useState<any>();
    const [totalPlayers, setTotalPlayers] = useState<BigNumber>();
    const [players, setPlayers] = useState<Player[]>([]);
    const coinsLeage = useContext(CoinsLeagueContext);
    const nowDate = BigNumber.from(Math.round(new Date().getTime()/1000));
    useEffect(()=> {
        if(coinsLeage.instance){
            coinsLeage.instance.attach(address).game().then((g) => {
            console.log(g);
             setGame({
                started: g.started,
                finished: g.finished,
                aborted: g.aborted,
                duration: g.duration,
                num_players: g.num_players,
                scores_done: g.scores_done,
                amount_to_play: ethers.utils.formatEther(g.amount_to_play),
                total_amount_collected: ethers.utils.formatEther(g.total_amount_collected),
                num_coins: g.num_coins.toString(),
                start_timestamp: g.start_timestamp,
                })
            })
            coinsLeage.instance.attach(address).totalPlayers().then((t) => {
                console.log(t.toString())
                setTotalPlayers(t);
            })
        }
    }, [coinsLeage])

    useEffect( () => {
        if(coinsLeage.instance && game && totalPlayers && totalPlayers.gt('0')){
            setPlayers([]);
            let play: Player[] = []
            coinsLeage.instance.attach(address).playerCoinFeeds(0).then(console.log)
            for (let index = 0; index < totalPlayers.toNumber(); index++) {
                coinsLeage.instance.attach(address).players(index).then(p=> {            
                    play.push({
                        score: p.score,
                        address: p.player_address,
                    })
                    setPlayers(play);   
                })        
            }
        }
    }, [totalPlayers, game, coinsLeage.instance])

    return  <div className='Game-View-Container'>
             <div className='Game-View-Detail'>
                 <h3>Game Details</h3>
                <ul>
                <li>Started: {String(game?.started)}</li>
                <li>Finished: {String(game?.finished)}</li>
                <li>Aborted: {String(game?.aborted)}</li>
                <li>Scores Done: {String(game?.scores_done)}</li>
                <li>Coins: {game?.num_coins}</li>
                <li>Players: {game?.num_players.toString()}</li>
                <li>Duration: {game?.duration.toString()} Minutes</li>
                <li>Amount Play: {game?.amount_to_play} Matic</li>
                <li>Total Collected: {game?.total_amount_collected} Matic</li>
            </ul>
            </div>
           {(game && totalPlayers) && <div>
            {(totalPlayers.sub(game.num_players).eq('0') && !game.started) &&    <StartGame address={address} />}
             {(!totalPlayers.sub(game.num_players).eq('0')  && !game.started) && <JoinGame address={address} />}
             {game.started && !game.finished && nowDate.sub(game.start_timestamp).sub(game.duration).gte('0') &&  <EndGame address={address} timestamp={game.start_timestamp.add(game.duration)}/>}       
               {game.finished && <ClaimGame address={address}/>}
               <AbortGame address={address}/>
                   <div>
                     {players.map((p, ind)=> <PlayerView  player={p} key={ind}  />)}
                  </div>
               </div>
               
               
               }
            </div>
}