// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Municoin is ERC20 {

    address public owner;
    uint256 public tokenPrice; // price per Municoin token in wei

    constructor(uint256 initialSupply, uint256 _tokenPrice) ERC20("Municoin", "MUNI") {
        owner = msg.sender;
        _mint(msg.sender, initialSupply); // Mint initial supply to the owner's address
        tokenPrice = _tokenPrice; // Set token price
    }

    // Function to buy Municoin tokens
    function buyTokens() public payable {
        uint256 amountToBuy = msg.value / tokenPrice; // Calculate the number of tokens to buy
        require(amountToBuy > 0, "You need to send some ether to buy tokens");
        _transfer(owner, msg.sender, amountToBuy);
    }

    // Function to allow the owner to withdraw ether
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }
}
