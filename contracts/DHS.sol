pragma solidity > 0.6.99 < 0.8.0;
pragma experimental ABIEncoderV2;

contract DHS
{
struct PaymentLog{
    bytes32 ailment;
    uint256 cost;
}

struct Hospital{
    address payable hospitalAddress;
    PaymentLog invoice;
}

struct Patient{
    uint256 expiration;
    uint weight;
    bool isValid;
}


struct Treatment {
    address payable hospitalAddress;
    address patientAddress;
    PaymentLog [] receipt;
    uint256 date;
    bool isPaid;
}

mapping (address => uint256) memPool;
mapping (address => Patient) patients;
mapping (uint256 => Hospital[]) hospitals;
mapping (address => uint) noPatients;

Treatment [] treatments;

uint public constant premium = 3 ether;
uint public constant requiredPatients = 2;
uint public constant requiredHospitals = 1;
uint public duration = block.timestamp + 365 days;
uint public fundingPeriod = block.timestamp + 15 minutes;
uint public patientSize = 0;
uint public hospitalSize = 0;
uint public treatmentSize = 0;
bool public isActive = false;

function payPremium () payable public{
    if(msg.value < premium){
        revert();
    }
 //if patient is expire , renew insurance
    if(patients[msg.sender].isValid){
        if(patients[msg.sender].expiration > block.timestamp){
            patients[msg.sender].expiration = duration;
            memPool[msg.sender] = msg.value;
        }
        else{
            if(fundingPeriod > block.timestamp){
                patients[msg.sender] = Patient({expiration: fundingPeriod + 365 days , weight: 1 , isValid: true });
            }
            else{
                patients[msg.sender] = Patient({expiration: duration , weight: 1 , isValid: true});
            }
            patientSize++;
            memPool[msg.sender] = msg.value;
        }
    if (!isActive && block.timestamp > fundingPeriod){
        if(requiredPatients >= patientSize && requiredHospitals >= hospitalSize){
           isActive = true;
        }
    }
}
}

function addPremium () public{
    if(!patients[msg.sender].isValid){
        revert();
    }
    if (!(isActive) && block.timestamp > fundingPeriod){
        patients[msg.sender].isValid = false;
        if(!msg.sender.send(premium)){
            patients[msg.sender].isValid = true;
        }
    }
}

function getBalance () view public returns(uint256){
    return (memPool[msg.sender]);
}

function registerHospital (address payable hospitalAddress , PaymentLog memory log) public{
    hospitals[hospitalSize].push(Hospital({hospitalAddress: hospitalAddress , invoice: log }));
hospitalSize++;
}

function transferInsurance (address to) payable public{
    Patient memory sender = patients[msg.sender];
    if (sender.weight == 0 && !(patients[to].isValid)){
        revert();
    }
    memPool[to] += msg.value; patients[to].weight += 1;
    memPool[msg.sender] -= msg.value; patients[msg.sender].weight -= 1;
}

function requestPayment (address payable patientAddress , PaymentLog memory transaction) public returns(uint){
    if(!isActive && block.timestamp > fundingPeriod){
        if(patientSize >= requiredPatients && hospitalSize >= requiredHospitals){
            isActive = true;
        }
    }
    if(isActive){
        treatments.push(Treatment({hospitalAddress:msg.sender , patientAddress: patientAddress , receipt: transaction , date: block.timestamp , isPaid: false}));
    treatmentSize++;
    return treatmentSize - 1;
    }
 return 0;
}

function approvePayment (uint256 index) payable public{
    if(treatments[index].isPaid){
        revert();
    }
    if(msg.sender != treatments[index].patientAddress){
        revert();
    }
    if(treatments[index].hospitalAddress.send(treatments[index].receipt.cost)){
        if(treatments[index].receipt.cost <= memPool[msg.sender]){
            memPool[msg.sender] -= treatments[index].receipt.cost;
            treatments[index].isPaid = true;
        }
    }
}

function treatmentHistory () view public returns (Treatment memory){
  Treatment memory treatment;
    for (uint x = 0; x < treatmentSize; x++){
        if(treatments[x].patientAddress == msg.sender){
            treatment = treatments[x];
        }
    }
    return treatment;
}

function catalogue () view public /*returns (PaymenLog memory)*/{

}

function isActivate () view public returns(bool){
    return (isActive);
}

}