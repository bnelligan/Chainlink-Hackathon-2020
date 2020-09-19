pragma solidity > 0.6.99 < 0.8.0;

contract InsurancePool
{
    address owner;

    uint256 memberCount;
    uint256 memberMaxCount = 1000;
    uint256 price;
    uint256 totalValue;
    uint256 dollarLimit = price * 10;
    uint256 percentLimit;   // Formula needed Func(N)

    mapping (address => bool) approvedProviders;    // Replace with roles from open zepplin
    mapping (address => bool) approvedMember;       // Replace with roles from open zepplin
    mapping (address => bool) memberAutoRenew;      // Replace with roles from open zepplin
    mapping (address => uint256) memberPayments;
    
    constructor(uint256 price, uint256 memberMaxCount) {
        
    }
}