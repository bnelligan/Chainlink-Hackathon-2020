// SPDX-License-Identifier: MIT
pragma solidity > 0.6.99 < 0.8.0;
pragma experimental ABIEncoderV2;

import "Patient.sol";
import "Hospital.sol";
import "Transaction.sol";

contract Reedem is Hospital , Patient
{

struct log {
    bytes32 diseaseType;
    uint256 hospitalId;
    uint256 amountSpent;
}

struct historyLog {
    address payable member;
    log logBook;
}

mapping (address => historyLog[]) history;

address payable redeemer;

constructor () {
    redeemer = msg.sender;
}

event Send (address payable member , address payable delegate , uint256 amount);

function Reedeem (log memory Log) public{
    require (isPayed(redeemer));
    require (Log.amountSpent <= utxo[redeemer].amount);
    require (Log.amountSpent <= patients[redeemer].premium);
        history[redeemer].push(historyLog({
            member: redeemer,
            logBook: Log
        }));
    require (Log.hospitalId == hospitals[Log.hospitalId].hospitalId);
        utxo[redeemer].amount -= Log.amountSpent;
        emit Send (redeemer , hospitals[Log.hospitalId].pool , Log.amountSpent);
}

function History (address payable owner) view public returns (historyLog memory) {
    historyLog memory hospitalHistory;
    for (uint256 x = 0; x < history[owner].length; x++){
        hospitalHistory = history[owner][x];
    }
    return hospitalHistory;
}
}