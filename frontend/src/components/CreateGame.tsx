import { useCallback, useState } from "react"


/**
 * Create Game
 * @returns 
 */
export const CreateGame = () => {
   const [numPlayers, setNumPlayers] = useState();
   const [duration, setDuration] = useState();
   const [amount, setAmount] = useState();
   const [abortTimestamp, setAbortTimestamp] = useState();


   const onSubmit = useCallback(()=> {


    },[])


    return <form onSubmit={onSubmit}>
                <label>Number of players:</label>
                <input type="text" id="numPlayers" name="numPlayers" value={numPlayers} required/>
                <label>Duration:</label>
                <input type="text" id="duration" name="duration" />
                <label>Amount:</label>
                <input type="text" id="amount" name="amount" />
                <label>Nr Coins:</label>
                <input type="text" id="coins" name="coins" />
                <label>Abort Timestamp:</label>
                <input type="text" id="abort" name="abort" />
                <input type="submit" value="Submit" />
           </form>


}