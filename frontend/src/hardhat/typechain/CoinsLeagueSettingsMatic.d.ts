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
  CallOverrides,
} from "@ethersproject/contracts";
import { BytesLike } from "@ethersproject/bytes";
import { Listener, Provider } from "@ethersproject/providers";
import { FunctionFragment, EventFragment, Result } from "@ethersproject/abi";
import { TypedEventFilter, TypedEvent, TypedListener } from "./commons";

interface CoinsLeagueSettingsMaticInterface extends ethers.utils.Interface {
  functions: {
    "getBITTMultiplier()": FunctionFragment;
    "getChampionsMultiplier()": FunctionFragment;
    "getHouseAddress()": FunctionFragment;
    "getPrizesPlayers()": FunctionFragment;
    "getPrizesTwoPlayers()": FunctionFragment;
    "isAllowedAmountCoins(uint256)": FunctionFragment;
    "isAllowedAmountPlayers(uint256)": FunctionFragment;
    "isAllowedAmounts(uint256)": FunctionFragment;
    "isAllowedTimeFrame(uint256)": FunctionFragment;
    "isChainLinkFeed(address)": FunctionFragment;
  };

  encodeFunctionData(
    functionFragment: "getBITTMultiplier",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "getChampionsMultiplier",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "getHouseAddress",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "getPrizesPlayers",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "getPrizesTwoPlayers",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "isAllowedAmountCoins",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "isAllowedAmountPlayers",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "isAllowedAmounts",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "isAllowedTimeFrame",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "isChainLinkFeed",
    values: [string]
  ): string;

  decodeFunctionResult(
    functionFragment: "getBITTMultiplier",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getChampionsMultiplier",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getHouseAddress",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getPrizesPlayers",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "getPrizesTwoPlayers",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isAllowedAmountCoins",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isAllowedAmountPlayers",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isAllowedAmounts",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isAllowedTimeFrame",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "isChainLinkFeed",
    data: BytesLike
  ): Result;

  events: {};
}

export class CoinsLeagueSettingsMatic extends Contract {
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

  interface: CoinsLeagueSettingsMaticInterface;

  functions: {
    getBITTMultiplier(overrides?: CallOverrides): Promise<[BigNumber]>;

    "getBITTMultiplier()"(overrides?: CallOverrides): Promise<[BigNumber]>;

    getChampionsMultiplier(overrides?: CallOverrides): Promise<[BigNumber]>;

    "getChampionsMultiplier()"(overrides?: CallOverrides): Promise<[BigNumber]>;

    getHouseAddress(overrides?: CallOverrides): Promise<[string]>;

    "getHouseAddress()"(overrides?: CallOverrides): Promise<[string]>;

    getPrizesPlayers(
      overrides?: CallOverrides
    ): Promise<[[BigNumber, BigNumber, BigNumber]]>;

    "getPrizesPlayers()"(
      overrides?: CallOverrides
    ): Promise<[[BigNumber, BigNumber, BigNumber]]>;

    getPrizesTwoPlayers(
      overrides?: CallOverrides
    ): Promise<[[BigNumber, BigNumber]] & { prizes: [BigNumber, BigNumber] }>;

    "getPrizesTwoPlayers()"(
      overrides?: CallOverrides
    ): Promise<[[BigNumber, BigNumber]] & { prizes: [BigNumber, BigNumber] }>;

    isAllowedAmountCoins(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    "isAllowedAmountCoins(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    isAllowedAmountPlayers(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    "isAllowedAmountPlayers(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    isAllowedAmounts(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    "isAllowedAmounts(uint256)"(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    isAllowedTimeFrame(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    "isAllowedTimeFrame(uint256)"(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    isChainLinkFeed(
      feed: string,
      overrides?: CallOverrides
    ): Promise<[boolean]>;

    "isChainLinkFeed(address)"(
      feed: string,
      overrides?: CallOverrides
    ): Promise<[boolean]>;
  };

  getBITTMultiplier(overrides?: CallOverrides): Promise<BigNumber>;

  "getBITTMultiplier()"(overrides?: CallOverrides): Promise<BigNumber>;

  getChampionsMultiplier(overrides?: CallOverrides): Promise<BigNumber>;

  "getChampionsMultiplier()"(overrides?: CallOverrides): Promise<BigNumber>;

  getHouseAddress(overrides?: CallOverrides): Promise<string>;

  "getHouseAddress()"(overrides?: CallOverrides): Promise<string>;

  getPrizesPlayers(
    overrides?: CallOverrides
  ): Promise<[BigNumber, BigNumber, BigNumber]>;

  "getPrizesPlayers()"(
    overrides?: CallOverrides
  ): Promise<[BigNumber, BigNumber, BigNumber]>;

  getPrizesTwoPlayers(
    overrides?: CallOverrides
  ): Promise<[BigNumber, BigNumber]>;

  "getPrizesTwoPlayers()"(
    overrides?: CallOverrides
  ): Promise<[BigNumber, BigNumber]>;

  isAllowedAmountCoins(
    num: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  "isAllowedAmountCoins(uint256)"(
    num: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  isAllowedAmountPlayers(
    num: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  "isAllowedAmountPlayers(uint256)"(
    num: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  isAllowedAmounts(
    amount: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  "isAllowedAmounts(uint256)"(
    amount: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  isAllowedTimeFrame(
    time: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  "isAllowedTimeFrame(uint256)"(
    time: BigNumberish,
    overrides?: CallOverrides
  ): Promise<boolean>;

  isChainLinkFeed(feed: string, overrides?: CallOverrides): Promise<boolean>;

  "isChainLinkFeed(address)"(
    feed: string,
    overrides?: CallOverrides
  ): Promise<boolean>;

  callStatic: {
    getBITTMultiplier(overrides?: CallOverrides): Promise<BigNumber>;

    "getBITTMultiplier()"(overrides?: CallOverrides): Promise<BigNumber>;

    getChampionsMultiplier(overrides?: CallOverrides): Promise<BigNumber>;

    "getChampionsMultiplier()"(overrides?: CallOverrides): Promise<BigNumber>;

    getHouseAddress(overrides?: CallOverrides): Promise<string>;

    "getHouseAddress()"(overrides?: CallOverrides): Promise<string>;

    getPrizesPlayers(
      overrides?: CallOverrides
    ): Promise<[BigNumber, BigNumber, BigNumber]>;

    "getPrizesPlayers()"(
      overrides?: CallOverrides
    ): Promise<[BigNumber, BigNumber, BigNumber]>;

    getPrizesTwoPlayers(
      overrides?: CallOverrides
    ): Promise<[BigNumber, BigNumber]>;

    "getPrizesTwoPlayers()"(
      overrides?: CallOverrides
    ): Promise<[BigNumber, BigNumber]>;

    isAllowedAmountCoins(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    "isAllowedAmountCoins(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    isAllowedAmountPlayers(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    "isAllowedAmountPlayers(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    isAllowedAmounts(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    "isAllowedAmounts(uint256)"(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    isAllowedTimeFrame(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    "isAllowedTimeFrame(uint256)"(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<boolean>;

    isChainLinkFeed(feed: string, overrides?: CallOverrides): Promise<boolean>;

    "isChainLinkFeed(address)"(
      feed: string,
      overrides?: CallOverrides
    ): Promise<boolean>;
  };

  filters: {};

  estimateGas: {
    getBITTMultiplier(overrides?: CallOverrides): Promise<BigNumber>;

    "getBITTMultiplier()"(overrides?: CallOverrides): Promise<BigNumber>;

    getChampionsMultiplier(overrides?: CallOverrides): Promise<BigNumber>;

    "getChampionsMultiplier()"(overrides?: CallOverrides): Promise<BigNumber>;

    getHouseAddress(overrides?: CallOverrides): Promise<BigNumber>;

    "getHouseAddress()"(overrides?: CallOverrides): Promise<BigNumber>;

    getPrizesPlayers(overrides?: CallOverrides): Promise<BigNumber>;

    "getPrizesPlayers()"(overrides?: CallOverrides): Promise<BigNumber>;

    getPrizesTwoPlayers(overrides?: CallOverrides): Promise<BigNumber>;

    "getPrizesTwoPlayers()"(overrides?: CallOverrides): Promise<BigNumber>;

    isAllowedAmountCoins(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "isAllowedAmountCoins(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    isAllowedAmountPlayers(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "isAllowedAmountPlayers(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    isAllowedAmounts(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "isAllowedAmounts(uint256)"(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    isAllowedTimeFrame(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "isAllowedTimeFrame(uint256)"(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    isChainLinkFeed(
      feed: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;

    "isChainLinkFeed(address)"(
      feed: string,
      overrides?: CallOverrides
    ): Promise<BigNumber>;
  };

  populateTransaction: {
    getBITTMultiplier(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "getBITTMultiplier()"(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getChampionsMultiplier(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "getChampionsMultiplier()"(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getHouseAddress(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "getHouseAddress()"(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getPrizesPlayers(overrides?: CallOverrides): Promise<PopulatedTransaction>;

    "getPrizesPlayers()"(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    getPrizesTwoPlayers(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "getPrizesTwoPlayers()"(
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    isAllowedAmountCoins(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "isAllowedAmountCoins(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    isAllowedAmountPlayers(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "isAllowedAmountPlayers(uint256)"(
      num: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    isAllowedAmounts(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "isAllowedAmounts(uint256)"(
      amount: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    isAllowedTimeFrame(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "isAllowedTimeFrame(uint256)"(
      time: BigNumberish,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    isChainLinkFeed(
      feed: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;

    "isChainLinkFeed(address)"(
      feed: string,
      overrides?: CallOverrides
    ): Promise<PopulatedTransaction>;
  };
}
