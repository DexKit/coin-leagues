import { useCallback, useContext } from "react"
import { CoinsLeagueContext } from "../../hardhat/SymfoniContext";



interface Props{
    address?: string;
}

export const AbortGame = (props: Props) => {
    const { address } = props;
    const coinsLeage = useContext(CoinsLeagueContext);
    const onAbortGame = useCallback(() => {
        if(coinsLeage.instance && address){
            coinsLeage.instance?.attach(address).abortGame().then(()=> {
                alert("Game cancelled")
            })
        }
    },[address, coinsLeage])

    const onWithdrawGame = useCallback(() => {
        coinsLeage.instance?.withdraw().then(()=> {
            alert("Withdraw")
        })     
    },[])

    return   <div>
                 <h1> Abort Game</h1>
                 <button onClick={onAbortGame}>Abort</button>
                 <button onClick={onWithdrawGame}>Withdraw</button>
             </div>

}