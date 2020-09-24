// SPDX-License-Identifier: MIT
pragma solidity > 0.6.99 < 0.8.0;
import "Patient.sol";
import "Transaction.sol";

contract Hospital is Transaction
{
struct hospitalData{
    uint256 hospitalId;
    address payable pool;
    uint256 noPatients;
}

mapping (uint256 => hospitalData) internal hospitals;

function getNoPatient () public {
   //To do later
}

function registerHospital (uint256 hospitalId , address payable delegate) public {
    hospitals[hospitalId].hospitalId = hospitalId;
    hospitals[hospitalId].pool = delegate;
    hospitals[hospitalId].noPatients = 0;
}

}
