import { useCallback } from "react"




export const StartGame = () => {

    const onStartGame = useCallback(() => {

        
    }, [])

    return    <>
                 <h1> Start Game</h1>
                 <button onClick={onStartGame}>Start</button>
             </>

}