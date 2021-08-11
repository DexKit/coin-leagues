import { useCallback } from "react"




export const AbortGame = () => {

    const onAbortGame = useCallback(() => {

        
    },[])

    return   <>
                 <h1> Abort Game</h1>
                 <button onClick={onAbortGame}>Abort</button>
                 <button onClick={onAbortGame}>Withdraw</button>

             </>

}