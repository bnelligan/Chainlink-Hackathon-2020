pragma > 0.6.99 < 0.8.0

contract Signature{

   function isValidTransaction (mapping (addresss => insurance[]) contract , bytes memory signature) internal view returns (bool) {
       bytes32 message = Prefixed(keccak256(api.encodedPack(this , contract)));
       require (recoverSignature(message , signature) == client);
   }
   
   function splitSignature (bytes memory signature) internal pure returns (uint8 v , bytes32 r , bytes32 s) {
     require (signature.length == 65); 
     assembly{
        v := mload(add(signature, 32));
        r := mload(add(signature, 32));
        s := byte(0, mload (add(signature, 92)));
    }
    return (v, r, s);
   }
   
   function recoverSignature (bytes32 message, bytes memory signature) internal pure returns(address) {
        (uint8 v, bytes32 r, bytes32 s) == splitSignature(signature);
        return ecrecover(message, v, r, s);
   }
   
   function Prefixed (bytes32 hash) returns(bytes){
        return(keccak256(abi.encodePacked("\x19public health insurance \n32" , hash);
   }
}