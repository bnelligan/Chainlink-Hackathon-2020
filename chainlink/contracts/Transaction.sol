// SPDX-License-Identifier: MIT
pragma solidity > 0.6.99 < 0.8.0;

/*
 "Author":"https://github.com/oasisMystre"
*/

contract Transaction {
uint256 constant price = 3000;
address payable public client;

struct transaction {
    address payable member;
    uint256 amount;
    uint256 duration;
}

mapping (address => transaction) internal Membership;

constructor (){
   client = msg.sender;
}

function addPremium (uint256 amount , uint256 lifespan) internal {
    require (amount == price , "Error: Check pricing for more Information");
       uint256 expire = block.timestamp + lifespan;
       Membership[client].amount += amount;
       Membership[client].member = client; 
       Membership[client].duration = expire;
}

function isPayed (address payable member) internal view returns(bool) {
   require (Membership[member].amount == price , "Error: Check pricing for more information");
   require (Membership[member].amount != 0 , "Error: Your premium is exhausted");
       return true;
    }

function Renewal (address payable member , uint256 newDuration) public {
    require (Membership[member].member == member , "Error: You don't have an insurance plan");
    require (newDuration > Membership[member].duration , "Error: Can't renew contract , invalid duration");
        Membership[member].duration = newDuration;
}

function hasExpired (address payable member) public view returns(bool) {
    require (Membership[member].member == member , "Error: You don't have an insurance plan");
    require (block.timestamp >= Membership[member].duration);
        return true;
}
}