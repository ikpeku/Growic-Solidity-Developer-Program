pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

/**
 * @title Flow
 * @dev mint a token
 */

// verify contract address on etherscan : 0x882f23071f16bdEc084a08602918879C9Da924A8

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Inheritance is ERC20 {
    constructor() ERC20("Flow", "FLW") {}

    
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}



