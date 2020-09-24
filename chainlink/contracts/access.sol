// SPDX-License-Identifier: MIT
pragma solidity > 0.6.99 < 0.8.0;
import "transaction.sol";

/*
 "Author":"https://github.com/oasisMystre"
*/

contract Access is Transaction
{
struct Patient{
    uint256 hospitalId;
    address payable member;
    uint256 amount;
    bool autoRenewal;
}

struct Hospital{
    address payable funds;
    uint256 noPatients;
}

mapping (address => Patient[]) patients;
mapping (uint256 => Hospital[]) hospital;

function registerHospital (uint256 hospitalId , address payable funds) public {
        hospital[hospitalId].push(Hospital({
            funds: funds,
            noPatients: 0
        }));
    }

function register (uint256 hospitalId , address payable client) public {
    require (isPayed(client) , "Error: You don't have an insurance plan");
    if (hasExpired(client)){
        patients[client].push(Patient({
            hospitalId: hospitalId,
            member: client,
            amount: Membership[client].amount,
            autoRenewal: true
        }));
    }
}

function renewContract (address payable client , uint256 newDuration) public {
for (uint x = 0; x < patients[client].length; x++){
    require (patients[client][x].autoRenewal);
        Renewal (client , newDuration);
}
}

function setNumberOfPatients (uint256 hospitalId) public {
    Patient storage patient = patients[msg.sender][0];
    require (isPayed(patient.member));
    require (patient.hospitalId == hospitalId);
        hospital[hospitalId][0].noPatients += 1;
}

}