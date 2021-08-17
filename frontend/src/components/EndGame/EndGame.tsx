import { BigNumber } from "ethers";
import { useCallback, useContext } from "react";
import { CoinsLeagueContext } from "../../hardhat/SymfoniContext";


interface Props{
    address?: string;
    timestamp: BigNumber
}

export const EndGame = (props: Props) => {
    const {address, timestamp} = props;
    const coinsLeage = useContext(CoinsLeagueContext);
    const onEndGame = useCallback(() => {
        if(address && coinsLeage.instance){
            coinsLeage.instance?.attach(address).endGame().then(()=> alert("game ended"))
        }
          
    }, [address, coinsLeage]);
    return   <section>
                 <h1> End Game</h1>
                 <button onClick={onEndGame}>End Game</button>
                 <p>Game will end at {new Date(timestamp.mul(1000).toNumber()).toString()} </p>
             </section>

}