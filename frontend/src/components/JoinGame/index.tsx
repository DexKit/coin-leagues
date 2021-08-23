import { ethers } from "ethers";
import { ChangeEvent, useCallback, useContext, useState } from "react"
import { MumbaiPriceFeeds } from "../../constants/MaticFeeds";
import { CoinsLeagueContext } from "../../hardhat/SymfoniContext";
import "./style.css";
interface SelectProps{
    value?: string;
    onChange: (value: string) => void
}

const SelectCoins = (props: SelectProps) => {
    const {onChange, value} = props;
        const onChangeCoin = (ev: ChangeEvent<HTMLSelectElement> ) => {
            onChange(ev.target.value);
        }

 return   <label>
            Choose Coin:
            <select value={value} onChange={onChangeCoin}>
                {MumbaiPriceFeeds.map((feed)=> <option value={feed.address}>{feed.base}/{feed.quote}</option>)}
            </select>
        </label>

}



interface Props{
    address?: string;
}


export const JoinGame = (props: Props) => {
    const {address} = props;
    const coinsLeage = useContext(CoinsLeagueContext);
    const [coin1, setCoin1] = useState<string>(MumbaiPriceFeeds[0].address);
    const [coin2, setCoin2] = useState<string>(MumbaiPriceFeeds[1].address);
    const [coin3, setCoin3] = useState<string>(MumbaiPriceFeeds[2].address);
    const [coin4, setCoin4] = useState<string>(MumbaiPriceFeeds[3].address);
    const [coin5, setCoin5] = useState<string>(MumbaiPriceFeeds[4].address);
    const [coin6, setCoin6] = useState<string>(MumbaiPriceFeeds[5].address);

    const onSubmit = useCallback((ev:any) => {
        ev.preventDefault();
        if(coin1 && coin2 && coin3 && coin4 && coin5 && coin6 && address){
            console.log(coin1)
            coinsLeage.instance?.attach(address).joinGame([coin1, coin2], {value: ethers.utils.parseEther('0.1')}).then(()=> {
                alert('joined game');
            })
        }
    }, [coin1, coin2, coin3, coin4, coin5, coin6, address, coinsLeage.instance])

    return  <section className="join-game-section">
                <h3> Join Game </h3>

                <form onSubmit={onSubmit} className="join-game-form">
                            <SelectCoins value={coin1} onChange={(value: string) => setCoin1(value)} />
                            <SelectCoins value={coin2} onChange={(value: string) => setCoin2(value)} />
                            <SelectCoins value={coin3} onChange={(value: string) => setCoin3(value)} />
                            <SelectCoins value={coin4} onChange={(value: string) => setCoin4(value)} />
                            <SelectCoins value={coin5} onChange={(value: string) => setCoin5(value)} />
                            <SelectCoins value={coin6} onChange={(value: string) => setCoin6(value)} />
                            <input type="submit" value="Submit" />
                    </form>
        </section>


}