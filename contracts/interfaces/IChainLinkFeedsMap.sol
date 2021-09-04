//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface IChainLinkFeedsMap {
    function isChainLinkFeed(address feed) external view returns (bool);
}
