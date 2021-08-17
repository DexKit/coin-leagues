import React from 'react';
import logo from './logo.svg';
import './App.css';

import { Symfoni } from "./hardhat/SymfoniContext";
import { CreateGame } from './components/CreateGame';
import { Wallet } from './components/Wallet/Wallet';
import { GamesList } from './components/GamesList';


function App() {
  return (
    <div className="App">
      <Symfoni>
        <header>
          Coins League
        </header>
        <section className="App-section" >
          <CreateGame />
          <GamesList />
          <Wallet/>
        </section>
      </Symfoni>
    </div>
  );
}

export default App;
