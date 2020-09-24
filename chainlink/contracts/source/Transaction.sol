// SPDX-License-Identifier: MIT
pragma solidity > 0.6.99 < 0.8.0;
import "Tools/Price.sol";
import "Tools/Signature.sol";

contract Transaction is Signature , Price
{
/*
    "@struct transactionData template for unspent output (utxo) container"
*/

struct transactionData{
    uint256 amount;
    uint256 expiration;
    address payable beneficiary;
}

/*
    "@data container utxo for unspent premium subscriptions"
    "Note":"utxo contain transactionData list for support of multiple transaction"
*/

mapping (address => transactionData) utxo;

/*
    "@function addPremium calls the addTransactionData function"
    "@function addTransactionData to add data container utxo"
    "Note":"check Signature.sol @function claimPayment for explanation"
*/

function addTransactionData (address payable client , uint256 amount , uint256 duration) internal  {
    utxo[client].amount = amount;
    utxo[client].beneficiary = client;
    utxo[client].expiration = duration;
}

function addPremium (address payable client , uint256 amount , uint256 duration) public {
    require (amount == price);
        addTransactionData (client , amount , duration);
}

function hasExpired (address payable owner) public returns(bool) {
    require (block.timestamp >= utxo[owner].expiration);
        destroyTransaction(owner);
        return true;
}

function isPayed (address payable owner) public returns(bool) {
    require (!hasExpired(owner));
    require (utxo[owner].amount != 0);
        return true;
}
}