pragma solidity > 0.6.99 < 0.8.0;

contract Transaction
{
    address payable client;
    event broadcast (address payable from , address payable pool , uint amount);
    mapping (address => uint) utxo;
    
    constructor() payable {
        sender = msg.sender;
    }
    function mine (address payable receiver , uint amount) public{
        require(msg.sender == client);
        require(amount < 1e60);
        utxo[receiver] += amount;
    }
    function send(address payable receiver , uint amount) public{
        require(msg.sender == client);
        require(amount <= utxo[msg.sender] , "insufficient funds");
        utxo[msg.sender] -= amount;
        utxo[receiver] += amount;
        emit broadcast(msg.sender , receiver , amount);
    }
    function balance() internal view returns(uint){
        return utxo[client];
    }
}