//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./interfaces/IChainLinkFeedsMapMumbai";


contract ChainLinkFeedsMapMumbai is IChainLinkFeedsMapMumbai{
    
     mapping(address => bool) private chainlink_feeds;

     constructor(){
          // BTC / USD
          chainlink_feeds[0x007A22900a3B98143368Bd5906f8E17e9867581b] = true;
          // DAI / USD
          chainlink_feeds[0x0FCAa9c899EC5A91eBc3D5Dd869De833b06fB046] = true;
          // ETH / USD
          chainlink_feeds[0x0715A7794a1dc8e42615F059dD6e406A6594651A] = true;
          // MATIC / USD
          chainlink_feeds[0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada] = true;
          // USDC / USD
          chainlink_feeds[0x572dDec9087154dC5dfBB1546Bb62713147e0Ab0] = true;
         // USDT / USD
          chainlink_feeds[0x92C09849638959196E976289418e5973CC96d645] = true;
     }

    
    function isChainLinkFeed(address feed) public view returns (bool){
         return chainlink_feed[feed];
    }


}