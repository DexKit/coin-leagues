//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IChainLinkFeedsMapETHMainnet {
    function isChainLinkFeed(address) external view returns (bool);
}
