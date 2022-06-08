// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract TetherMumbai is ERC20, ERC20Burnable {
    function decimals() public pure override returns (uint8) {
        return 6;
    }

    constructor(
        string memory name,
        string memory symbol,
        uint256 max_supply
    ) ERC20(name, symbol) {
        _mint(msg.sender, max_supply * 10**decimals());
    }
}
