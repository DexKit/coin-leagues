import { useCallback, useContext } from "react";
import { CoinsLeagueContext } from "../../hardhat/SymfoniContext";


interface Props{
    address?: string;
}

export const StartGame = (props: Props) => {
    const {address} = props;
    const coinsLeage = useContext(CoinsLeagueContext);
    const onStartGame = useCallback(() => {
        if(address && coinsLeage.instance){
            coinsLeage.instance?.attach(address).startGame().then(()=> {
                alert('start game');
            });
     }
        
    },[address, coinsLeage.instance])

    return <>
                 <h1> Start Game</h1>
                 <button onClick={onStartGame}>Start</button>

             </>

}