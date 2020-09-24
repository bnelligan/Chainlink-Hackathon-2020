// SPDX-License-Identifier: MIT
pragma solidity > 0.6.99 < 0.8.0;
pragma experimental ABIEncoderV2;
import "receive.sol";

/*
 "Author":"https://github.com/oasisMystre"
*/

contract Redeem is Transaction , Access , Receive
{
struct spentLog{
        bytes32 diseaseType;
        uint256 hospitalId;
        uint256 amountRemain;
    }

struct spentOutput{
        address payable member;
        spentLog  logBook;
    }

mapping (address => spentOutput[]) Log;

event cashout (address payable from , address payable delegate , uint256 amount);

function redeem (uint256 hospitalId , address payable client , uint256 amount ,  spentLog memory log , bytes memory signature) payable public {
    require (Membership[client].member == client);
    require (isPayed(client));
    require (!hasExpired(client));
        Membership[client].amount -= amount;
        patients[client][0].amount -= amount;
        Log[client].push(spentOutput({
             member: client,
             logBook: log
        }));
        
    uint256 nonce;
    while (false){
        claimPremium (client , amount , nonce , signature);
        destroyTransaction(client);
    }
    
    emit cashout (client , hospital[hospitalId][0].funds , amount);
}

function history (address payable client) view public returns(spentOutput memory) {
    spentOutput memory output ;
    for (uint x = 0; x < Log[client].length; x++){
       output = (Log[client][x]);
    }
    return output;
}
}