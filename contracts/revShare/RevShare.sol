//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../interfaces/IChampions.sol";

contract RevShare is Ownable {
    using SafeERC20 for IERC20;
    IChampions internal immutable CHAMPIONS =
        IChampions(0xf2a669A2749073E55c56E27C2f4EdAdb7BD8d95D);

    struct Share {
        uint256 amount;
        uint256 total_claims;
        uint256 start_timestamp;
        uint256 duration;
        uint256 amount_claimed;
        address token_to_share;
        mapping(address => uint256) claims;
        mapping(address => bool) claimed;
        mapping(uint256 => bool) ids;
    }

    event CreatedShare(
        uint256 id,
        uint256 amount,
        uint256 start_timestamp,
        uint256 duration,
        address token_share
    );

    event UpdatedShare(
        uint256 id,
        uint256 amount,
        uint256 start_timestamp,
        uint256 duration,
        address token_share
    );

    event ShareSubscribed(
        address subscriber,
        uint256 claims,
        uint256 subscribed_at
    );
    event ShareClaimed(address subscriber, uint256 amount, uint256 claimed_at, address token_to_share);

    Share[] public shares;

    function createShare(
        uint256 amount,
        uint256 start_timestamp,
        uint256 duration,
        address token
    ) external onlyOwner {
        require(start_timestamp > block.timestamp, "require future date");
        uint256 id = shares.length;
        Share storage sh = shares.push();
        sh.amount = amount;
        sh.start_timestamp = start_timestamp;
        sh.duration = duration;
        sh.token_to_share = token;
        sh.amount_claimed = 0;
        emit CreatedShare(id, amount, start_timestamp, duration, token);
    }
    /**
    /* Update share, only possible if share not started yet
     */
    function updateShare(
        uint256 id,
        uint256 amount,
        uint256 start_timestamp,
        uint256 duration,
        address token
    ) external onlyOwner {
        require(id < shares.length, "id not exist");
        Share storage sh = shares[id];
        require(block.timestamp < sh.start_timestamp, "Share already started, could not be updated");
        require(start_timestamp > block.timestamp, "require future date");
        sh.amount = amount;
        sh.start_timestamp = start_timestamp;
        sh.duration = duration;
        sh.token_to_share = token;
        emit UpdatedShare(id, amount, start_timestamp, duration, token);
    }

    function subscribeShare(uint256 id, uint256[] memory championsIDs)
        external
    {
        Share storage share = shares[id];
        require(
            share.start_timestamp > block.timestamp,
            "share subscribe period not started yet"
        );
        require(
            share.start_timestamp + share.duration > block.timestamp,
            "Subscribe for this id already expired"
        );
        for (uint256 index = 0; index < championsIDs.length; index++) {
            uint256 championId = championsIDs[index];
            if (
                CHAMPIONS.ownerOf(championId) == msg.sender &&
                !share.ids[championId]
            ) {
                share.ids[championId] = true;
                if (share.claims[msg.sender] == 0) {
                    share.claims[msg.sender] = 1;
                } else {
                    share.claims[msg.sender] = share.claims[msg.sender] + 1;
                }
                share.total_claims = share.total_claims + 1;
            }
        }
        emit ShareSubscribed(
            msg.sender,
            share.claims[msg.sender],
            block.timestamp
        );
    }

    function claimShare(uint256 id) external {
        require(shares.length > id, "Id Not exists");
        Share storage share = shares[id];
        require(
            share.start_timestamp + share.duration > block.timestamp,
            "Still on subscribe period"
        );
        require(share.claimed[msg.sender] == false, "already claimed");
        share.claimed[msg.sender] = true;
        uint256 amount_per_claim = share.amount / share.total_claims;
        uint256 total_amount_claim = amount_per_claim * share.claims[msg.sender];   
        IERC20(share.token_to_share).safeTransfer(msg.sender, total_amount_claim);
        share.amount_claimed = share.amount_claimed + total_amount_claim;
        emit ShareClaimed(msg.sender, total_amount_claim, block.timestamp, share.token_to_share);
    }

    // Owner can withdraw tokens transferred to contract
    function withdrawToken(address token) external onlyOwner {
        IERC20(token).safeTransfer(owner(), IERC20(token).balanceOf(address(this)));
    }

    function getClaimsOf(uint256 id) external view returns (uint256){
         Share storage share = shares[id];
         return share.claims[msg.sender];
    }

    function getLastShare() external view returns (uint256){
        return shares.length;
    }

}
