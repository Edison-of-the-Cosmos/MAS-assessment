// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts@4.4.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.4.2/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.4.2/access/Ownable.sol";

contract WorthlessToken is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("Worthless Token", "WOT") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
