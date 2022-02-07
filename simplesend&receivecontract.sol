// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ironbank {
    
    address public boss;
    uint public balance;

    constructor() {
        boss = msg.sender;
    }

    receive() payable external {
        balance += msg.value;
    }

    function withdraw(uint amount, address payable destinationaddress) public {
        require(msg.sender == boss, "How dare you try to steal from here");
        require(amount <= balance, "There is not enough money here");
        
        destinationaddress.transfer(amount);
        balance -= amount;
    }
}