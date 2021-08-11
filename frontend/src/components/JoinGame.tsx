import { ChangeEvent, useState } from "react"

interface Props{
    value?: string;
    onChange: (value: string) => void
}

const SelectCoins = (props: Props) => {
    const {onChange, value} = props;
        const onChangeCoin = (ev: ChangeEvent<HTMLSelectElement> ) => {
            onChange(ev.target.value);
        }

 return   <label>
    Choose Coin:
          <select value={value} onChange={onChangeCoin}>
            <option value="laranja">Laranja</option>
            <option value="limao">Limão</option>
            <option value="coco">Coco</option>
            <option value="manga">Manga</option>
          </select>
</label>

}






export const JoinGame = () => {
    const [coin1, setCoin1] = useState<string>();
    const [coin2, setCoin2] = useState<string>();
    const [coin3, setCoin3] = useState<string>();
    const [coin4, setCoin4] = useState<string>();
    const [coin5, setCoin5] = useState<string>();
    const [coin6, setCoin6] = useState<string>();

    const onSubmit = () => {


    }
    return <form onSubmit={onSubmit}>
                <SelectCoins value={coin1} onChange={(value: string) => setCoin1(value)} />
                <SelectCoins value={coin2} onChange={(value: string) => setCoin2(value)} />
                <SelectCoins value={coin3} onChange={(value: string) => setCoin3(value)} />
                <SelectCoins value={coin4} onChange={(value: string) => setCoin4(value)} />
                <SelectCoins value={coin5} onChange={(value: string) => setCoin5(value)} />
                <SelectCoins value={coin6} onChange={(value: string) => setCoin6(value)} />
                <input type="submit" value="Submit" />
        </form>


}