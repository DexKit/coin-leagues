//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IChainLinkFeedsMapMumbai {
   function isChainLinkFeed(address) public view returns(bool);
}