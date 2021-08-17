import { useCallback, useContext, useEffect, useState } from "react"
import { CoinsLeagueContext, SignerContext } from "../../hardhat/SymfoniContext";


interface Props{
    address?: string;
}

export const ClaimGame = (props: Props) => {
    const {address} = props;
    const [winner, setWinner] = useState<any>();
    const [account, setAccount] = useState<string>();
    const coinsLeage = useContext(CoinsLeagueContext);
    const signer = useContext(SignerContext);
    useEffect(() => {
        if(coinsLeage.instance && address && account) {
            coinsLeage.instance?.attach(address).winners(account).then(
                w => 
                setWinner({
                    place: w.place,
                    address: w.winner_address,
                    score: w.score,
                    claimed: w.claimed
                }));
        }
        

    }, [coinsLeage.instance, address, account])

    
 
    useEffect(()=> {
        if(signer && signer[0]){
            signer[0].getAddress().then(a=> setAccount(a));

        }

    }, [signer])


    const onClaimGame = useCallback(() => {
        if(address){
            coinsLeage.instance?.attach(address).claim().then(()=> alert('claimed prize'));
        }   
    }, [address])

    return    <>
                 <h1>Claim Game</h1>
              {(account && account.toLowerCase() === winner?.address.toLowerCase()) ?   
              <>
              
              {!winner.claimed && <button onClick={onClaimGame}>Claim</button>}
                <p>Place: {winner.place}</p>
                <p>Score: {winner.score.toString()}</p>
              </>

                : <> <h3>Not Winner</h3> </>}
             </>

}