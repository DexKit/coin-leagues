//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IChampions is IERC721 {
    function getRarityOf(uint256) external view returns (uint256);
}
