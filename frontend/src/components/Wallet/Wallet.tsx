import { useContext, useEffect, useState } from "react"
import { SignerContext } from "../../hardhat/SymfoniContext"

import './style.css'

export const Wallet = () => {
    const signer = useContext(SignerContext);
    const [address, setAddress] = useState<string>();
    useEffect(()=> {
        if(signer && signer[0]){
            signer[0].getAddress().then(a=> setAddress(a));

        }

    }, [signer])



    return <div className="wallet-section">
             {!address ? <button>Connect Wallet</button> : <p>Connected Wallet <b>{address}</b></p>}    
           </div>
}