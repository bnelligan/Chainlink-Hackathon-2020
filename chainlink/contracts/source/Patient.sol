// SPDX-License-Identifier: MIT
pragma solidity > 0.6.99 < 0.8.0;
import "Transaction.sol";

contract Patient is Transaction
{

/*
    "@struct patientData : a template for  "
*/

struct patientData{
    address member;
    uint256 premium;
    bool autoRenewal;
}

/*
  "@param uint256 m_premium for deposited amount"
  "@param address m_member for insured address"
*/

address payable public  m_member;

/*
    "@param patients for holding patientData's"
*/

mapping (address => patientData) internal patients;

constructor (){
    m_member = msg.sender;
}

function addPatientData (bool autorenewal) public {
    patients[m_member].member = utxo[msg.sender].beneficiary;
    patients[m_member].premium = utxo[msg.sender].amount;
    patients[m_member].autoRenewal = autorenewal;
}

function registerPatient (bool renewalStatus) public {
    require (isPayed(m_member));
    require (!hasExpired(m_member));
        addPatientData (renewalStatus);
}

function renewal (uint256 newDuration) public {
    require (patients[m_member].autoRenewal);
    require (newDuration > utxo[m_member].expiration);
        utxo[m_member].expiration = block.timestamp + newDuration;
}
} //Patient