//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../interfaces/IChampions.sol";

contract RevShare is Ownable{

    using SafeERC20 for IERC20;
    IChampions internal immutable CHAMPIONS =
        IChampions(0xf2a669A2749073E55c56E27C2f4EdAdb7BD8d95D);

    IERC20 internal immutable BITTOKEN =
        IERC20(0x518445F0dB93863E5e93A7F70617c05AFa8048f1);

    struct Share{
        uint256 amount;
        uint256 total_claims;
        uint256 start_timestamp;
        uint256 duration;
        mapping(address => uint256) claims;
        mapping(address => bool) claimed;
    }

    event CreatedShare(uint256 id, uint256 amount, uint256 start_timestamp, uint256 duration);
    event ShareSubscribed(address subscriber, uint256 claims, uint256 subscribedAt);
    event ShareClaimed(address subscriber, uint256 amount, uint256 claimedAt);

    Share[] public shares;

    function createShare(uint256 amount, uint256 start_timestamp, uint256 duration) external onlyOwner{
        require(start_timestamp > block.timestamp, "require future date");
        uint256 id = shares.length;
        Share storage sh = shares.push();
        sh.amount = amount;
        sh.start_timestamp = start_timestamp;
        sh.duration = duration;
        emit CreatedShare(id, amount, start_timestamp, duration);
    }


    function subscribeShare(uint256 id) external {
        Share storage share = shares[id];
        require(share.start_timestamp > block.timestamp, "share subscribe period not started yet");
        require(share.start_timestamp + share.duration < block.timestamp, "Subscribe for this id already expired");
        share.claims[msg.sender] = CHAMPIONS.balanceOf(msg.sender);
        share.total_claims = share.total_claims + CHAMPIONS.balanceOf(msg.sender);
        emit ShareSubscribed(msg.sender, share.claims[msg.sender], block.timestamp);
    }

    function claimShare(uint256 id) external{
        require(shares.length < id, "Id Not exists");
        Share storage share = shares[id];
        require(share.start_timestamp + share.duration > block.timestamp, "Still on subscribe period");
        require(share.claimed[msg.sender] == false, "already claimed");
        share.claimed[msg.sender] = true;
        uint256 amountPerClaim = share.amount/share.total_claims;
        uint256 totalAmountClaim = amountPerClaim*share.claims[msg.sender];
        BITTOKEN.safeTransfer(msg.sender, totalAmountClaim );
        emit ShareClaimed(msg.sender, totalAmountClaim, block.timestamp);
    }

    // Owner can withdraw tokens transferred to contract
    function withdrawToken() external onlyOwner{
        BITTOKEN.safeTransfer(owner(), BITTOKEN.balanceOf(address(this)));
    }



}