/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import {
  ethers,
  EventFilter,
  Signer,
  BigNumber,
  BigNumberish,
  PopulatedTransaction,
} from "ethers";
import {
  Contract,
  ContractTransaction,
  Overrides,
  PayableOverrides,
  CallOverrides,
} from "@ethersproject/contracts";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";
import { TypedEventFilter, TypedEvent, TypedListener } from "./commons";

interface CoinsLeagueInterface extends ethers.utils.Interface {
  functions: {
    "abortGame()": FunctionFragment;
    "amountToHouse()": FunctionFragment;
    "claim()": FunctionFragment;
    "coins(address)": FunctionFragment;
    "endGame()": FunctionFragment;
    "game()": FunctionFragment;
    "getCurrentScoresOf(uint256)": FunctionFragment;
    "getPlayers()": FunctionFragment;
    "getPriceFeed(address)": FunctionFragment;
    "houseClaim()": FunctionFragment;
    "joinGame(address[])": FunctionFragment;
    "playerCoinFeeds(uint256)": FunctionFragment;
    "players(uint256)": FunctionFragment;
    "startGame()": FunctionFragment;
    "totalCollected()": FunctionFragment;
    "totalPlayers()": FunctionFragment;
    "winners(address)": FunctionFragment;
    "withdraw()": FunctionFragment;
  };

  encodeFunctionData(functionFragment: "abortGame", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "amountToHouse",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "claim", values?: undefined): string;
  encodeFunctionData(functionFragment: "coins", values: [string]): string;
  encodeFunctionData(functionFragment: "endGame", values?: undefined): string;
  encodeFunctionData(functionFragment: "game", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "getCurrentScoresOf",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getPlayers",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "getPriceFeed",
    values: [string]
  ): string;
  encodeFunctionData(
    functionFragment: "houseClaim",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "joinGame", values: [string[]]): string;
  encodeFunctionData(
    functionFragment: "playerCoinFeeds",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "players",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "startGame", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "totalCollected",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "totalPlayers",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "winners", values: [string]): string;
  encodeFunctionData(functionFragment: "withdraw", values?: undefined): string;

  decodeFunctionResult(functionFragment: "abortGame", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "amountToHouse",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "claim", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "coins", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "endGame", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "game", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "getCurrentScoresOf",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "getPlayers", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "getPriceFeed",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "houseClaim", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "joinGame", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "playerCoinFeeds",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "players", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "startGame", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "totalCollected",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "totalPlayers",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "winners", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "withdraw", data: BytesLike): Result;

  events: {
    "AbortedGame(uint256)": EventFragment;
    "Claimed(address,uint256)": EventFragment;
    "EndedGame(uint256)": EventFragment;
    "HouseClaimed()": EventFragment;
    "JoinedGame(address)": EventFragment;
    "StartedGame(uint256)": EventFragment;
  };

  getEvent(nameOrSignatureOrTopic: "AbortedGame"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "Claimed"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "EndedGame"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "HouseClaimed"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "JoinedGame"): EventFragment;
  getEvent(nameOrSignatureOrTopic: "StartedGame"): EventFragment;
}

export class CoinsLeague extends Contract {
  connect(signerOrProvider: Signer | Provider | string): this;
  attach(addressOrName: string): this;
  deployed(): Promise<this>;

  listeners(eventName?: string): Array<Listener>;
  off(eventName: string, listener: Listener): this;
  on(eventName: string, listener: Listener): this;
  once(eventName: string, listener: Listener): this;
  removeListener(eventName: string, listener: Listener): this;
  removeAllListeners(eventName?: string): this;

  listeners<T, G>(
    eventFilter?: TypedEventFilter<T, G>
  ): Array<TypedListener<T, G>>;
  off<T, G>(
    eventFilter: TypedEventFilter<T, G>,
    listener: TypedListener<T, G>
  ): this;
  on<T, G>(
    eventFilter: TypedEventFilter<T, G>,
    listener: TypedListener<T, G>
  ): this;
  once<T, G>(
    eventFilter: TypedEventFilter<T, G>,
    listener: TypedListener<T, G>
  ): this;
  removeListener<T, G>(
    eventFilter: TypedEventFilter<T, G>,
    listener: TypedListener<T, G>
  ): this;
  removeAllListeners<T, G>(eventFilter: TypedEventFilter<T, G>): this;

  queryFilter<T, G>(
    event: TypedEventFilter<T, G>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEvent<T & G>>>;

  interface: CoinsLeagueInterface;

  functions: {
    abortGame(overrides?: Overrides): Promise<ContractTransaction>;

    "abortGame()"(overrides?: Overrides): Promise<ContractTransaction>;

    amountToHouse(overrides?: CallOverrides): Promise<[BigNumber]>;

    "amountToHouse()"(overrides?: CallOverrides): Promise<[BigNumber]>;

    claim(overrides?: Overrides): Promise<ContractTransaction>;

    "claim()"(overrides?: Overrides): Promise<ContractTransaction>;

    coins(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber, BigNumber, BigNumber] & {
        coin_feed: string;
        start_price: BigNumber;
        end_price: BigNumber;
        score: BigNumber;
      }
    >;

    "coins(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber, BigNumber, BigNumber] & {
        coin_feed: string;
        start_price: BigNumber;
        end_price: BigNumber;
        score: BigNumber;
      }
    >;

    endGame(overrides?: Overrides): Promise<ContractTransaction>;

    "endGame()"(overrides?: Overrides): Promise<ContractTransaction>;

    game(
      overrides?: CallOverrides
    ): Promise<
      [
        number,
        boolean,
        boolean,
        boolean,
        boolean,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber
      ] & {
        game_type: number;
        started: boolean;
        scores_done: boolean;
        finished: boolean;
        aborted: boolean;
        num_coins: BigNumber;
        num_players: BigNumber;
        duration: BigNumber;
        start_timestamp: BigNumber;
        abort_timestamp: BigNumber;
        amount_to_play: BigNumber;
        total_amount_collected: BigNumber;
      }
    >;

    "game()"(
      overrides?: CallOverrides
    ): Promise<
      [
        number,
        boolean,
        boolean,
        boolean,
        boolean,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber
      ] & {
        game_type: number;
        started: boolean;
        scores_done: boolean;
        finished: boolean;
        aborted: boolean;
        num_coins: BigNumber;
        num_players: BigNumber;
        duration: BigNumber;
        start_timestamp: BigNumber;
        abort_timestamp: BigNumber;
        amount_to_play: BigNumber;
        total_amount_collected: BigNumber;
      }
    >;

    getCurrentScoresOf(
      index: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    "getCurrentScoresOf(uint256)"(
      index: BigNumberish,
      overrides?: Overrides
    ): Promise<ContractTransaction>;

    getPlayers(
      overrides?: CallOverrides
    ): Promise<
      [
        ([string[], string, BigNumber] & {
          coin_feeds: string[];
          player_address: string;
          score: BigNumber;
        })[]
      ]
    >;

    "getPlayers()"(
      overrides?: CallOverrides
    ): Promise<
      [
        ([string[], string, BigNumber] & {
          coin_feeds: string[];
          player_address: string;
          score: BigNumber;
        })[]
      ]
    >;

    getPriceFeed(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<[BigNumber]>;

    "getPriceFeed(address)"(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<[BigNumber]>;

    houseClaim(overrides?: Overrides): Promise<ContractTransaction>;

    "houseClaim()"(overrides?: Overrides): Promise<ContractTransaction>;

    joinGame(
      coin_feeds: string[],
      overrides?: PayableOverrides
    ): Promise<ContractTransaction>;

    "joinGame(address[])"(
      coin_feeds: string[],
      overrides?: PayableOverrides
    ): Promise<ContractTransaction>;

    playerCoinFeeds(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[string[]]>;

    "playerCoinFeeds(uint256)"(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[string[]]>;

    players(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber] & { player_address: string; score: BigNumber }
    >;

    "players(uint256)"(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber] & { player_address: string; score: BigNumber }
    >;

    startGame(overrides?: Overrides): Promise<ContractTransaction>;

    "startGame()"(overrides?: Overrides): Promise<ContractTransaction>;

    totalCollected(overrides?: CallOverrides): Promise<[BigNumber]>;

    "totalCollected()"(overrides?: CallOverrides): Promise<[BigNumber]>;

    totalPlayers(overrides?: CallOverrides): Promise<[BigNumber]>;

    "totalPlayers()"(overrides?: CallOverrides): Promise<[BigNumber]>;

    winners(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [number, string, BigNumber, boolean] & {
        place: number;
        winner_address: string;
        score: BigNumber;
        claimed: boolean;
      }
    >;

    "winners(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [number, string, BigNumber, boolean] & {
        place: number;
        winner_address: string;
        score: BigNumber;
        claimed: boolean;
      }
    >;

    withdraw(overrides?: Overrides): Promise<ContractTransaction>;

    "withdraw()"(overrides?: Overrides): Promise<ContractTransaction>;
  };

  abortGame(overrides?: Overrides): Promise<ContractTransaction>;

  "abortGame()"(overrides?: Overrides): Promise<ContractTransaction>;

  amountToHouse(overrides?: CallOverrides): Promise<BigNumber>;

  "amountToHouse()"(overrides?: CallOverrides): Promise<BigNumber>;

  claim(overrides?: Overrides): Promise<ContractTransaction>;

  "claim()"(overrides?: Overrides): Promise<ContractTransaction>;

  coins(
    arg0: string,
    overrides?: CallOverrides
  ): Promise<
    [string, BigNumber, BigNumber, BigNumber] & {
      coin_feed: string;
      start_price: BigNumber;
      end_price: BigNumber;
      score: BigNumber;
    }
  >;

  "coins(address)"(
    arg0: string,
    overrides?: CallOverrides
  ): Promise<
    [string, BigNumber, BigNumber, BigNumber] & {
      coin_feed: string;
      start_price: BigNumber;
      end_price: BigNumber;
      score: BigNumber;
    }
  >;

  endGame(overrides?: Overrides): Promise<ContractTransaction>;

  "endGame()"(overrides?: Overrides): Promise<ContractTransaction>;

  game(
    overrides?: CallOverrides
  ): Promise<
    [
      number,
      boolean,
      boolean,
      boolean,
      boolean,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber
    ] & {
      game_type: number;
      started: boolean;
      scores_done: boolean;
      finished: boolean;
      aborted: boolean;
      num_coins: BigNumber;
      num_players: BigNumber;
      duration: BigNumber;
      start_timestamp: BigNumber;
      abort_timestamp: BigNumber;
      amount_to_play: BigNumber;
      total_amount_collected: BigNumber;
    }
  >;

  "game()"(
    overrides?: CallOverrides
  ): Promise<
    [
      number,
      boolean,
      boolean,
      boolean,
      boolean,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber,
      BigNumber
    ] & {
      game_type: number;
      started: boolean;
      scores_done: boolean;
      finished: boolean;
      aborted: boolean;
      num_coins: BigNumber;
      num_players: BigNumber;
      duration: BigNumber;
      start_timestamp: BigNumber;
      abort_timestamp: BigNumber;
      amount_to_play: BigNumber;
      total_amount_collected: BigNumber;
    }
  >;

  getCurrentScoresOf(
    index: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  "getCurrentScoresOf(uint256)"(
    index: BigNumberish,
    overrides?: Overrides
  ): Promise<ContractTransaction>;

  getPlayers(
    overrides?: CallOverrides
  ): Promise<
    ([string[], string, BigNumber] & {
      coin_feeds: string[];
      player_address: string;
      score: BigNumber;
    })[]
  >;

  "getPlayers()"(
    overrides?: CallOverrides
  ): Promise<
    ([string[], string, BigNumber] & {
      coin_feeds: string[];
      player_address: string;
      score: BigNumber;
    })[]
  >;

  getPriceFeed(
    coin_feed: string,
    overrides?: CallOverrides
  ): Promise<BigNumber>;

  "getPriceFeed(address)"(
    coin_feed: string,
    overrides?: CallOverrides
  ): Promise<BigNumber>;

  houseClaim(overrides?: Overrides): Promise<ContractTransaction>;

  "houseClaim()"(overrides?: Overrides): Promise<ContractTransaction>;

  joinGame(
    coin_feeds: string[],
    overrides?: PayableOverrides
  ): Promise<ContractTransaction>;

  "joinGame(address[])"(
    coin_feeds: string[],
    overrides?: PayableOverrides
  ): Promise<ContractTransaction>;

  playerCoinFeeds(
    index: BigNumberish,
    overrides?: CallOverrides
  ): Promise<string[]>;

  "playerCoinFeeds(uint256)"(
    index: BigNumberish,
    overrides?: CallOverrides
  ): Promise<string[]>;

  players(
    arg0: BigNumberish,
    overrides?: CallOverrides
  ): Promise<
    [string, BigNumber] & { player_address: string; score: BigNumber }
  >;

  "players(uint256)"(
    arg0: BigNumberish,
    overrides?: CallOverrides
  ): Promise<
    [string, BigNumber] & { player_address: string; score: BigNumber }
  >;

  startGame(overrides?: Overrides): Promise<ContractTransaction>;

  "startGame()"(overrides?: Overrides): Promise<ContractTransaction>;

  totalCollected(overrides?: CallOverrides): Promise<BigNumber>;

  "totalCollected()"(overrides?: CallOverrides): Promise<BigNumber>;

  totalPlayers(overrides?: CallOverrides): Promise<BigNumber>;

  "totalPlayers()"(overrides?: CallOverrides): Promise<BigNumber>;

  winners(
    arg0: string,
    overrides?: CallOverrides
  ): Promise<
    [number, string, BigNumber, boolean] & {
      place: number;
      winner_address: string;
      score: BigNumber;
      claimed: boolean;
    }
  >;

  "winners(address)"(
    arg0: string,
    overrides?: CallOverrides
  ): Promise<
    [number, string, BigNumber, boolean] & {
      place: number;
      winner_address: string;
      score: BigNumber;
      claimed: boolean;
    }
  >;

  withdraw(overrides?: Overrides): Promise<ContractTransaction>;

  "withdraw()"(overrides?: Overrides): Promise<ContractTransaction>;

  callStatic: {
    abortGame(overrides?: CallOverrides): Promise<void>;

    "abortGame()"(overrides?: CallOverrides): Promise<void>;

    amountToHouse(overrides?: CallOverrides): Promise<BigNumber>;

    "amountToHouse()"(overrides?: CallOverrides): Promise<BigNumber>;

    claim(overrides?: CallOverrides): Promise<void>;

    "claim()"(overrides?: CallOverrides): Promise<void>;

    coins(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber, BigNumber, BigNumber] & {
        coin_feed: string;
        start_price: BigNumber;
        end_price: BigNumber;
        score: BigNumber;
      }
    >;

    "coins(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber, BigNumber, BigNumber] & {
        coin_feed: string;
        start_price: BigNumber;
        end_price: BigNumber;
        score: BigNumber;
      }
    >;

    endGame(overrides?: CallOverrides): Promise<void>;

    "endGame()"(overrides?: CallOverrides): Promise<void>;

    game(
      overrides?: CallOverrides
    ): Promise<
      [
        number,
        boolean,
        boolean,
        boolean,
        boolean,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber
      ] & {
        game_type: number;
        started: boolean;
        scores_done: boolean;
        finished: boolean;
        aborted: boolean;
        num_coins: BigNumber;
        num_players: BigNumber;
        duration: BigNumber;
        start_timestamp: BigNumber;
        abort_timestamp: BigNumber;
        amount_to_play: BigNumber;
        total_amount_collected: BigNumber;
      }
    >;

    "game()"(
      overrides?: CallOverrides
    ): Promise<
      [
        number,
        boolean,
        boolean,
        boolean,
        boolean,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber,
        BigNumber
      ] & {
        game_type: number;
        started: boolean;
        scores_done: boolean;
        finished: boolean;
        aborted: boolean;
        num_coins: BigNumber;
        num_players: BigNumber;
        duration: BigNumber;
        start_timestamp: BigNumber;
        abort_timestamp: BigNumber;
        amount_to_play: BigNumber;
        total_amount_collected: BigNumber;
      }
    >;

    getCurrentScoresOf(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "getCurrentScoresOf(uint256)"(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    getPlayers(
      overrides?: CallOverrides
    ): Promise<
      ([string[], string, BigNumber] & {
        coin_feeds: string[];
        player_address: string;
        score: BigNumber;
      })[]
    >;

    "getPlayers()"(
      overrides?: CallOverrides
    ): Promise<
      ([string[], string, BigNumber] & {
        coin_feeds: string[];
        player_address: string;
        score: BigNumber;
      })[]
    >;

    getPriceFeed(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "getPriceFeed(address)"(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    houseClaim(overrides?: CallOverrides): Promise<void>;

    "houseClaim()"(overrides?: CallOverrides): Promise<void>;

    joinGame(coin_feeds: string[], overrides?: CallOverrides): Promise<void>;

    "joinGame(address[])"(
      coin_feeds: string[],
      overrides?: CallOverrides
    ): Promise<void>;

    playerCoinFeeds(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<string[]>;

    "playerCoinFeeds(uint256)"(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<string[]>;

    players(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber] & { player_address: string; score: BigNumber }
    >;

    "players(uint256)"(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<
      [string, BigNumber] & { player_address: string; score: BigNumber }
    >;

    startGame(overrides?: CallOverrides): Promise<void>;

    "startGame()"(overrides?: CallOverrides): Promise<void>;

    totalCollected(overrides?: CallOverrides): Promise<BigNumber>;

    "totalCollected()"(overrides?: CallOverrides): Promise<BigNumber>;

    totalPlayers(overrides?: CallOverrides): Promise<BigNumber>;

    "totalPlayers()"(overrides?: CallOverrides): Promise<BigNumber>;

    winners(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [number, string, BigNumber, boolean] & {
        place: number;
        winner_address: string;
        score: BigNumber;
        claimed: boolean;
      }
    >;

    "winners(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<
      [number, string, BigNumber, boolean] & {
        place: number;
        winner_address: string;
        score: BigNumber;
        claimed: boolean;
      }
    >;

    withdraw(overrides?: CallOverrides): Promise<void>;

    "withdraw()"(overrides?: CallOverrides): Promise<void>;
  };

  filters: {
    AbortedGame(
      timestamp: null
    ): TypedEventFilter<[BigNumber], { timestamp: BigNumber }>;

    Claimed(
      playerAddress: null,
      place: null
    ): TypedEventFilter<
      [string, BigNumber],
      { playerAddress: string; place: BigNumber }
    >;

    EndedGame(
      timestamp: null
    ): TypedEventFilter<[BigNumber], { timestamp: BigNumber }>;

    HouseClaimed(): TypedEventFilter<[]>;

    JoinedGame(
      playerAddress: null
    ): TypedEventFilter<[string], { playerAddress: string }>;

    StartedGame(
      timestamp: null
    ): TypedEventFilter<[BigNumber], { timestamp: BigNumber }>;
  };

  estimateGas: {
    abortGame(overrides?: Overrides): Promise<BigNumber>;

    "abortGame()"(overrides?: Overrides): Promise<BigNumber>;

    amountToHouse(overrides?: CallOverrides): Promise<BigNumber>;

    "amountToHouse()"(overrides?: CallOverrides): Promise<BigNumber>;

    claim(overrides?: Overrides): Promise<BigNumber>;

    "claim()"(overrides?: Overrides): Promise<BigNumber>;

    coins(arg0: string, overrides?: CallOverrides): Promise<BigNumber>;

    "coins(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    endGame(overrides?: Overrides): Promise<BigNumber>;

    "endGame()"(overrides?: Overrides): Promise<BigNumber>;

    game(overrides?: CallOverrides): Promise<BigNumber>;

    "game()"(overrides?: CallOverrides): Promise<BigNumber>;

    getCurrentScoresOf(
      index: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    "getCurrentScoresOf(uint256)"(
      index: BigNumberish,
      overrides?: Overrides
    ): Promise<BigNumber>;

    getPlayers(overrides?: CallOverrides): Promise<BigNumber>;

    "getPlayers()"(overrides?: CallOverrides): Promise<BigNumber>;

    getPriceFeed(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "getPriceFeed(address)"(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    houseClaim(overrides?: Overrides): Promise<BigNumber>;

    "houseClaim()"(overrides?: Overrides): Promise<BigNumber>;

    joinGame(
      coin_feeds: string[],
      overrides?: PayableOverrides
    ): Promise<BigNumber>;

    "joinGame(address[])"(
      coin_feeds: string[],
      overrides?: PayableOverrides
    ): Promise<BigNumber>;

    playerCoinFeeds(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "playerCoinFeeds(uint256)"(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    players(arg0: BigNumberish, overrides?: CallOverrides): Promise<BigNumber>;

    "players(uint256)"(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    startGame(overrides?: Overrides): Promise<BigNumber>;

    "startGame()"(overrides?: Overrides): Promise<BigNumber>;

    totalCollected(overrides?: CallOverrides): Promise<BigNumber>;

    "totalCollected()"(overrides?: CallOverrides): Promise<BigNumber>;

    totalPlayers(overrides?: CallOverrides): Promise<BigNumber>;

    "totalPlayers()"(overrides?: CallOverrides): Promise<BigNumber>;

    winners(arg0: string, overrides?: CallOverrides): Promise<BigNumber>;

    "winners(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    withdraw(overrides?: Overrides): Promise<BigNumber>;

    "withdraw()"(overrides?: Overrides): Promise<BigNumber>;
  };

  populateTransaction: {
    abortGame(overrides?: Overrides): Promise<PopulatedTransaction>;

    "abortGame()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    amountToHouse(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "amountToHouse()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    claim(overrides?: Overrides): Promise<PopulatedTransaction>;

    "claim()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    coins(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "coins(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    endGame(overrides?: Overrides): Promise<PopulatedTransaction>;

    "endGame()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    game(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "game()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    getCurrentScoresOf(
      index: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    "getCurrentScoresOf(uint256)"(
      index: BigNumberish,
      overrides?: Overrides
    ): Promise<PopulatedTransaction>;

    getPlayers(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "getPlayers()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    getPriceFeed(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "getPriceFeed(address)"(
      coin_feed: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    houseClaim(overrides?: Overrides): Promise<PopulatedTransaction>;

    "houseClaim()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    joinGame(
      coin_feeds: string[],
      overrides?: PayableOverrides
    ): Promise<PopulatedTransaction>;

    "joinGame(address[])"(
      coin_feeds: string[],
      overrides?: PayableOverrides
    ): Promise<PopulatedTransaction>;

    playerCoinFeeds(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "playerCoinFeeds(uint256)"(
      index: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    players(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "players(uint256)"(
      arg0: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    startGame(overrides?: Overrides): Promise<PopulatedTransaction>;

    "startGame()"(overrides?: Overrides): Promise<PopulatedTransaction>;

    totalCollected(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "totalCollected()"(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    totalPlayers(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "totalPlayers()"(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    winners(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "winners(address)"(
      arg0: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    withdraw(overrides?: Overrides): Promise<PopulatedTransaction>;

    "withdraw()"(overrides?: Overrides): Promise<PopulatedTransaction>;
  };
}
