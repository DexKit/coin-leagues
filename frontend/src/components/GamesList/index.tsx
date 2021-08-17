import { useContext, useEffect, useState } from "react";
import { CoinsLeagueFactoryContext } from "../../hardhat/SymfoniContext";
import { GameView } from "../GamesView";

export const GamesList = () => {
  const [game1, setGame1] = useState<string>();
  const [game2, setGame2] = useState<string>();
  const [game3, setGame3] = useState<string>();
  const [totalGames, setTotalGames] = useState<number>();
  const coinsLeageFactory = useContext(CoinsLeagueFactoryContext);
  useEffect(() => {
    if (coinsLeageFactory.instance) {
      coinsLeageFactory.instance.coinsLeague(0).then((a) => {
        setGame1(a);
      });
      coinsLeageFactory.instance.coinsLeague(1).then((a) => {
        setGame2(a);
      });
      coinsLeageFactory.instance.coinsLeague(2).then((a) => {
        setGame3(a);
      });
      coinsLeageFactory.instance
        .totalGames()
        .then((t) => setTotalGames(t.toNumber()));
    }
  }, [coinsLeageFactory]);

  return (
    <div>
      <p>Total Games: {totalGames}</p>
      {game3 && (
        <div>
          <h3>Game: 3</h3>
          <GameView address={game3} />
        </div>
      )}
        {game2 && (
        <div>
          <h3>Game: 2</h3>
          <GameView address={game2} />
        </div>
      )}
      {game1 && (
        <div>
          <h3>Game: 1</h3>
          <GameView address={game1} />
        </div>
      )}

    
     
    </div>
  );
};
